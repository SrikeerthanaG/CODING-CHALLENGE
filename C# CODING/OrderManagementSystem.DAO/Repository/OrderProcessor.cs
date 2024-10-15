using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using OrderManagementSystem.Entity;
using OrderManagementSystem.Exception;
using OrderManagementSystem.Util;
using OrderManagementSystem.DAO.Service;

namespace OrderManagementSystem.DAO.Repository
{
    public class OrderProcessor : IOrderManagementRepository
    {
        private SqlConnection conn = DBUtil.getDBConnection();

        public void CreateOrder(User user, List<Product> products)
        {
            using (SqlConnection conn = new SqlConnection("YourConnectionString"))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Orders (userId) VALUES (@userId); SELECT SCOPE_IDENTITY();", conn))
            {
                cmd.Parameters.AddWithValue("@userId", user.UserId);
                int orderId = Convert.ToInt32(cmd.ExecuteScalar());

                foreach (var product in products)
                {
                    cmd.CommandText = "INSERT INTO OrderDetails (orderId, productId, quantity) VALUES (@orderId, @productId, @quantity)";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@orderId", orderId);
                    cmd.Parameters.AddWithValue("@productId", product.ProductId);
                    cmd.Parameters.AddWithValue("@quantity", 1);
                    cmd.ExecuteNonQuery();
                }
            }
                }
        }

        public void CancelOrder(int userId, int orderId)
        {
            using (SqlCommand cmd = new SqlCommand("DELETE FROM Orders WHERE orderId = @orderId AND userId = @userId", conn))
            {
                cmd.Parameters.AddWithValue("@orderId", orderId);
                cmd.Parameters.AddWithValue("@userId", userId);
                if (cmd.ExecuteNonQuery() == 0) throw new OrderNotFoundException("Order or User not found.");
            }
        }

        public void CreateProduct(User user, Product product)
        {
            if (user.Role != "Admin") throw new UnauthorizedAccessException("Only admin can create products.");
            string query = "INSERT INTO Product (productId, productName, description, price, quantityInStock, type) VALUES (@productId, @productName, @description, @price, @quantityInStock, @type)";
            if (product is Electronics) query += "; INSERT INTO Electronics (productId, brand, warrantyPeriod) VALUES (@productId, @brand, @warrantyPeriod)";
            else if (product is Clothing) query += "; INSERT INTO Clothing (productId, size, color) VALUES (@productId, @size, @color)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@productId", product.ProductId);
                cmd.Parameters.AddWithValue("@productName", product.ProductName);
                cmd.Parameters.AddWithValue("@description", product.Description);
                cmd.Parameters.AddWithValue("@price", product.Price);
                cmd.Parameters.AddWithValue("@quantityInStock", product.QuantityInStock);
                cmd.Parameters.AddWithValue("@type", product.Type);
                if (product is Electronics electronics)
                {
                    cmd.Parameters.AddWithValue("@brand", electronics.Brand);
                    cmd.Parameters.AddWithValue("@warrantyPeriod", electronics.WarrantyPeriod);
                }
                else if (product is Clothing clothing)
                {
                    cmd.Parameters.AddWithValue("@size", clothing.Size);
                    cmd.Parameters.AddWithValue("@color", clothing.Color);
                }
                cmd.ExecuteNonQuery();
            }
        }

        public void CreateUser(User user)
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO User_ (userId, username, password, role) VALUES (@userId, @username, @password, @role)", conn))
            {
                cmd.Parameters.AddWithValue("@userId", user.UserId);
                cmd.Parameters.AddWithValue("@username", user.Username);
                cmd.Parameters.AddWithValue("@password", user.Password);
                cmd.Parameters.AddWithValue("@role", user.Role);
                cmd.ExecuteNonQuery();
            }
        }

        public List<Product> GetAllProducts()
        {
            List<Product> products = new List<Product>();
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Product", conn))
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    products.Add(new Product(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetDouble(3), reader.GetInt32(4), reader.GetString(5)));
                }
            }
            return products;
        }

        public List<Product> GetOrderByUser(User user)
        {
            List<Product> products = new List<Product>();
            using (SqlCommand cmd = new SqlCommand("SELECT P.productId, P.productName, P.price FROM Product P JOIN OrderDetails OD ON P.productId = OD.productId JOIN Orders O ON O.orderId = OD.orderId WHERE O.userId = @userId", conn))
            {
                cmd.Parameters.AddWithValue("@userId", user.UserId);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        products.Add(new Product(reader.GetInt32(0), reader.GetString(1), null, reader.GetDouble(2), 0, null));
                    }
                }
            }
            return products;
        }
    }
}
