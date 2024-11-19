using System.Drawing;
using System.Net.Sockets;
using whois;
using MySql.Data.MySqlClient;
using MySql.Data;

namespace MyApp
{
    internal class Program
    {
        static Boolean debug = false;
        static Dictionary<String, User> DataBase = new Dictionary<String, User>
        {
            {
                "cssbct", new User{UserID="cssbct",Surname="Tompsett",Fornames="Brian C",Title="Eur Ing",Position="Lecturer of Computer Science",Phone="+44 1482 46 5222",Email="B.C.Tompsett@hull.ac.uk",Location="in RB-336" }
            }
        };
        static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                Console.WriteLine("Starting Server . . .");
                RunServer();
            }

            if (args.Length > 0) { for (int i = 0; i < args.Length; i++) { ProcessCommand(args[i]); } }
            else { for (int i = 0; i < args.Length; i++) { Console.WriteLine(args[i]); } }
        }
        // Handle a network request
        static void doRequest(NetworkStream socketStream)
        {
            StreamWriter sw = new StreamWriter(socketStream);
            StreamReader sr = new StreamReader(socketStream);
            if (debug) Console.WriteLine("Waiting for input from client...");
            try
            {
                String connect = sr.ReadLine();
                Console.WriteLine($"Received Network Command: '{connect}'");
                if (connect.StartsWith("open localhost"))
                {
                    // opening the connection
                    if (debug) Console.WriteLine("localhost open");
                }
                Console.WriteLine("Please type your command: ");
                String line = sr.ReadLine();
                Console.WriteLine(line);
                int content_length = 0;
                String info = "";
                String[] slices = [];
                while (line != "")
                {
                    if (line.StartsWith("Content-Length: "))
                    {
                        content_length = Int32.Parse(line.Substring(16));
                    }
                    line = sr.ReadLine();
                    Console.WriteLine(line);
                    if (debug) Console.WriteLine($"Skipped Header Line: '{line}'");
                }
                if (connect == null)
                {
                    if (debug) Console.WriteLine("Ignoring null command");
                    return;
                }
                if (connect == "POST / HTTP/1.1")
                {
                    //String[] Uslices = line.Split(new char[] { '&' }, 2);
                    //String UID = slices[0].Substring(5);
                    //String value = slices[1].Substring(9);
                    String UID = "'cssbct'", value = "'In The Lab'";
                    // The we have an update
                    if (debug) Console.WriteLine($"Received an update request for '{UID}' to '{value}'");
                    if (!DataBase.ContainsKey(UID)) DataBase.TryAdd(UID, new User { });
                    DataBase[UID].Location = value;
                    string connStr = "server=localhost;user=root;database=whois;port=3306;password=L3tM31n";
                    MySqlConnection conn = new MySqlConnection(connStr);
                    try
                    {
                        Console.WriteLine("Connecting to MySQL --- Tables");
                        conn.Open();
                        // Perform database operations
                        string sql = "UPDATE users SET location = " + value + " WHERE LoginID = " + UID;
                        MySqlCommand cmd = new MySqlCommand(sql, conn);
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            int r = Convert.ToInt32(result);
                            Console.WriteLine("Updated");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.ToString());
                    }
                    //conn.Close(); // close the connection
                    //Console.WriteLine("Done the job");
                }
                else if (connect.StartsWith("GET /?name=") && connect.EndsWith(" HTTP/1.1"))
                {
                    slices = connect.Split(" ");  // Split into 3 pieces
                    String userID = slices[1].Substring(7);  // start at the 7th letter of the middle slice - skip `/?name=`
                    // then we have a lookup
                    if (debug) Console.WriteLine("Received a lookup request");
                    if (DataBase.ContainsKey(userID))
                    {
                        String result = DataBase[userID].ToString();
                        sw.WriteLine("HTTP/1.1 200 OK");
                        sw.WriteLine("Content-Type: text/plain");
                        sw.WriteLine();
                        sw.WriteLine(result);
                        sw.Flush();
                        Console.WriteLine($"Performed Lookup on '{userID}' returning '{result}'");
                        sw.Close(); // delete after debug
                        sr.Close(); // delete after debug
                    }
                    else
                    {
                        // Not found
                        sw.WriteLine("HTTP/1.1 404 Not Found");
                        sw.WriteLine("Content-Type: text/plain");
                        sw.WriteLine();
                        sw.Flush();
                        Console.WriteLine($"Performed Lookup on '{userID}' returning '404 Not Found'");
                        sw.Close(); // delete after debug
                        sr.Close(); // delete after debug
                    }
                }
                else if (connect == "GET /favicon.ico HTTP/1.1")
                {
                    Console.WriteLine("Recieved success response from webpage");
                    sw.WriteLine();
                    sw.Flush();
                    sw.Close(); // delete after debug
                    sr.Close(); // delete after debug
                }
                else
                {
                    // We have an error
                    Console.WriteLine($"Unrecognised command: '{connect}'");
                    sw.WriteLine("HTTP/1.1 400 Bad Request");
                    sw.WriteLine("Content-Type: text/plain");
                    sw.WriteLine();
                    sw.Flush();
                    Console.WriteLine($"Performed Lookup on '{DataBase[slices[1]]}' returning '400: girl what?'");
                    sw.Close(); // delete after debug
                    sr.Close(); // delete after debug
                }
            }
            catch (Exception e)
            {
                Console.WriteLine($"Fault in command processing:{e.ToString()}");
            }
            finally
            {
                sw.Close();
                sr.Close();
            }
            //sw.WriteLine(line);   // Need to remove this line after testing
            //sw.Flush();           // Need to remove this line after testing  
        }
        static void RunServer()
        {
            // Initiate the Web Server task
            TcpListener listener;
            Socket connection;
            NetworkStream socketStream;
            try
            {
                listener = new TcpListener(443);
                listener.Start();
                while (true)
                {
                    if (debug) Console.WriteLine("Server Waiting connection...");
                    connection = listener.AcceptSocket();
                    connection.SendTimeout = 1000;
                    connection.ReceiveTimeout = 1000;
                    socketStream = new NetworkStream(connection);
                    doRequest(socketStream);
                    socketStream.Close();
                    connection.Close();
                }
            }
            catch (Exception e)
            {
                //log.log(e.ToString());
                Console.WriteLine(e.ToString());
            }
            if (debug) Console.WriteLine("Terminating Server");
        }

        // Process the next database command request
        static void ProcessCommand(string command)
        {
            try
            {
                String[] slice = command.Split(new char[] { '?' }, 2);
                String ID = slice[0];
                String operation = null;
                String update = null;
                String field = null;
                if (slice.Length == 2)
                {
                    operation = slice[1];
                    String[] pieces = operation.Split(new char[] { '=' }, 2);
                    field = pieces[0];
                    if (pieces.Length == 2) update = pieces[1];
                }
                if (debug) Console.Write($"Operation on ID '{ID}'");
                if (operation == null) Dump(ID);
                else if (update == null) Lookup(ID, field);
                else Update(ID, field, update);
                if (slice.Length == 2)
                {
                    operation = slice[1];
                    // Could be empty if no field specified
                    if (operation == "")
                    {
                        // Is a record delete command
                        Delete(ID);
                        return;
                    }
                }
                if (operation == null || update == null && (!DataBase.ContainsKey(ID)))
                {
                    Console.WriteLine($"User '{ID}' not known");
                    return;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine($"Fault in Command Processing: {e.ToString()}");
            }

            // Functions to process database requests
            static void Dump(String ID)
            {
                if (debug) Console.WriteLine(" output all fields");
                Console.WriteLine($"UserID={DataBase[ID].UserID}");
                Console.WriteLine($"Surname={DataBase[ID].Surname}");
                Console.WriteLine($"Fornames={DataBase[ID].Fornames}");
                Console.WriteLine($"Title={DataBase[ID].Title}");
                Console.WriteLine($"Position={DataBase[ID].Position}");
                Console.WriteLine($"Phone={DataBase[ID].Phone}");
                Console.WriteLine($"Email={DataBase[ID].Email}");
                Console.WriteLine($"location={DataBase[ID].Location}");
            }
            static void Lookup(String ID, String field)
            {
                if (debug) Console.WriteLine($" lookup field '{field}'");
                if (debug) Console.Write($"Operation on ID '{ID}'");
                String result = null;
                switch (field)
                {
                    case "location": result = DataBase[ID].Location; break;
                    case "UserID": result = DataBase[ID].UserID; break;
                    case "Surname": result = DataBase[ID].Surname; break;
                    case "Fornames": result = DataBase[ID].Fornames; break;
                    case "Title": result = DataBase[ID].Title; break;
                    case "Phone": result = DataBase[ID].Phone; break;
                    case "Position": result = DataBase[ID].Position; break;
                    case "Email": result = DataBase[ID].Email; break;
                }
                Console.WriteLine(result);
            }
            static void Update(String ID, String field, String update)
            {
                if (debug) Console.WriteLine($" update field '{field}' to '{update}'");
                if (!DataBase.ContainsKey(ID)) DataBase.TryAdd(ID, new User { });
                switch (field)
                {
                    case "location": DataBase[ID].Location = update; break;
                    case "UserID": DataBase[ID].UserID = update; break;
                    case "Surname": DataBase[ID].Surname = update; break;
                    case "Fornames": DataBase[ID].Fornames = update; break;
                    case "Title": DataBase[ID].Title = update; break;
                    case "Phone": DataBase[ID].Phone = update; break;
                    case "Position": DataBase[ID].Position = update; break;
                    case "Email": DataBase[ID].Email = update; break;
                }
                Console.WriteLine("OK");
            }
            static void Delete(String ID)
            {
                if (debug) Console.WriteLine($"Delete record '{ID}' from DataBase");
                DataBase.Remove(ID);
            }
        }
    }
}
