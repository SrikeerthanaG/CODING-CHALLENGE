using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

    namespace OrderManagementSystem.Util
    {
        public static class DBUtil
        {

            public static SqlConnection getDBConnection()
            {
                
            string connString = "Data Source=SRIKEERTHANA;Initial Catalog=oms;Integrated Security=True;TrustServerCertificate=True";
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            return conn;

        }
        
    }
    }


