//using BCrypt.Net;
//using System;
//using System.Collections.Generic;
//using System.Data.SqlClient;
//using System.Runtime.Serialization;
//using System.Text;

//namespace GadgetHub.Service
//{
//    [DataContract]
//    public class UserDTO
//    {
//        [DataMember]
//        public int Id { get; set; }

//        [DataMember]
//        public string Role { get; set; }
//    }

//    public class LoginService : ILoginService
//    {
//        private readonly string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\SOC\\GadgetHub\\GadgetHubDB.mdf;Integrated Security=True;Connect Timeout=30;Encrypt=False";

//        public UserDTO Login(string email, string password)
//        {
//            using (SqlConnection conn = new SqlConnection(connectionString))
//            {
//                string query = "SELECT Id, Password, Role FROM Users WHERE Email = @Email";
//                SqlCommand cmd = new SqlCommand(query, conn);
//                cmd.Parameters.AddWithValue("@Email", email);

//                conn.Open();
//                using (SqlDataReader reader = cmd.ExecuteReader())
//                {
//                    if (reader.Read())
//                    {
//                        int userId = reader.GetInt32(0);
//                        string hashedPassword = reader.GetString(1);
//                        string role = reader.GetString(2);

//                        if (BCrypt.Net.BCrypt.Verify(password, hashedPassword))
//                        {
//                            return new UserDTO { Id = userId, Role = role };
//                        }
//                    }
//                }
//            }
//            return null;
//        }

//    }
//}
