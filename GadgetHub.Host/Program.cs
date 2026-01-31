using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.Service; // Assuming the service interface is in this namespace

namespace GadgetHub.Host
{
    class Program
    {
        static void Main(string[] args)
        {
            using (ServiceHost host = new ServiceHost(typeof(GadgetHubService)))
            {
                host.Open();
                Console.WriteLine("Service is running at http://localhost:8733/GadgetHubService/");
                Console.WriteLine("Press Enter to terminate...");
                Console.ReadLine();
                host.Close();
            }
            //using (ServiceHost host = new ServiceHost(typeof(LoginService)))
            //{
            //    //host.Open();
            //    Console.WriteLine("Service is running at http://localhost:8733/LoginService/");
            //    Console.WriteLine("Press Enter to terminate...");
            //    Console.ReadLine();
            //    host.Close();
            //}
        }
    }
}
