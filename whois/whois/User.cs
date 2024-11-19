using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using whois;

namespace whois
{
    public class User
    {
        public User() { }
        public String UserID { get; set; }
        public String Surname { get; set; }
        public String Fornames { get; set; }
        public String Title { get; set; }
        public String Position { get; set; }
        public String Phone { get; set; }
        public String Email { get; set; }
        public String Location { get; set; }
        public User(String userID, String surname, String fornames, String title, String position, String phone, String email, String location)
        {
            UserID = userID;
            Surname = surname;
            Fornames = fornames;
            Title = title;
            Position = position;
            Phone = phone;
            Email = email;
            Location = location;
        }
        public override string ToString()
        {
            return $"""
                UserID = {this.UserID}
                Surname = {this.Surname}
                Fornames = {this.Fornames}
                Title = {this.Title}
                Position = {this.Position}
                Phone = {this.Phone}
                Email = {this.Email}
                Location = {this.Location}
                """;
        }
    }
}
