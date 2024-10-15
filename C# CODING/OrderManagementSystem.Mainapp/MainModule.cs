using System;
using System.Collections.Generic;
using OrderManagementSystem.Entity;
using OrderManagementSystem.DAO.Repository;
using OrderManagementSystem.Exception;
using OrderManagementSystem.DAO.Service;
using OrderManagementSystem.Util;

namespace OrderManagementSystem.Mainapp
{
    class Program
    {
  
        static void Main(string[] args)  
        {
            IOrderManagementRepository orderRepo = new OrderProcessor();
            bool exit = false;

            // Menu-driven loop
            while (!exit)
            {
                Console.WriteLine("\nMenu:");
                Console.WriteLine("1. Create User");
                Console.WriteLine("2. Create Product");
                Console.WriteLine("3. Create Order");
                Console.WriteLine("4. Cancel Order");
                Console.WriteLine("5. Get All Products");
                Console.WriteLine("6. Get Orders by User");
                Console.WriteLine("7. Exit");
                Console.Write("\nEnter your choice: ");

                int choice = Convert.ToInt32(Console.ReadLine());

                try
                {
                    switch (choice)
                    {
                        case 1:
                            CreateUser(orderRepo);
                            break;
                        case 2:
                            CreateProduct(orderRepo);
                            break;
                        case 3:
                            CreateOrder(orderRepo);
                            break;
                        case 4:
                            CancelOrder(orderRepo);
                            break;
                        case 5:
                            GetAllProducts(orderRepo);
                            break;
                        case 6:
                            GetOrderByUser(orderRepo);
                            break;
                        case 7:
                            exit = true;
                            Console.WriteLine("Exiting the application.");
                            break;
                        default:
                            Console.WriteLine("Invalid choice. Please try again.");
                            break;
                    }
                }
                catch (UserNotFoundException ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
                catch (OrderNotFoundException ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
                catch (System.Exception ex)
                {
                    Console.WriteLine("An unexpected error occurred: " + ex.Message);
                }
            }
        }

        // Method to create a user
        static void CreateUser(IOrderManagementRepository orderRepo)
        {
            Console.Write("Enter UserId: ");
            int userId = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter Username: ");
            string username = Console.ReadLine();

            Console.Write("Enter Password: ");
            string password = Console.ReadLine();

            Console.Write("Enter Role (Admin/User): ");
            string role = Console.ReadLine();

            User newUser = new User(userId, username, password, role);
            orderRepo.CreateUser(newUser);
            Console.WriteLine("User created successfully.");
        }

        // Method to create a product
        static void CreateProduct(IOrderManagementRepository orderRepo)
        {
            Console.Write("Enter Admin UserId: ");
            int userId = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter ProductId: ");
            int productId = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter Product Name: ");
            string productName = Console.ReadLine();

            Console.Write("Enter Description: ");
            string description = Console.ReadLine();

            Console.Write("Enter Price: ");
            double price = Convert.ToDouble(Console.ReadLine());

            Console.Write("Enter Quantity In Stock: ");
            int quantity = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter Product Type (Electronics/Clothing): ");
            string type = Console.ReadLine();

            User adminUser = new User(userId, "", "", "Admin");

            Product product;
            if (type == "Electronics")
            {
                Console.Write("Enter Brand: ");
                string brand = Console.ReadLine();
                Console.Write("Enter Warranty Period: ");
                int warrantyPeriod = Convert.ToInt32(Console.ReadLine());

                product = new Electronics(productId, productName, description, price, quantity, brand, warrantyPeriod);
            }
            else if (type == "Clothing")
            {
                Console.Write("Enter Size: ");
                string size = Console.ReadLine();
                Console.Write("Enter Color: ");
                string color = Console.ReadLine();

                product = new Clothing(productId, productName, description, price, quantity, size, color);
            }
            else
            {
                Console.WriteLine("Invalid product type.");
                return;
            }

            orderRepo.CreateProduct(adminUser, product);
            Console.WriteLine("Product created successfully.");
        }

        // Method to create an order
        static void CreateOrder(IOrderManagementRepository orderRepo)
        {
            Console.Write("Enter UserId: ");
            int userId = Convert.ToInt32(Console.ReadLine());

            User user = new User(userId, "", "", "User");

            List<Product> products = new List<Product>();

            Console.Write("Enter number of products in the order: ");
            int productCount = Convert.ToInt32(Console.ReadLine());

            for (int i = 0; i < productCount; i++)
            {
                Console.Write("Enter ProductId for product " + (i + 1) + ": ");
                int productId = Convert.ToInt32(Console.ReadLine());

                Product product = new Product { ProductId = productId };
                products.Add(product);
            }

            orderRepo.CreateOrder(user, products);
            Console.WriteLine("Order created successfully.");
        }

        // Method to cancel an order
        static void CancelOrder(IOrderManagementRepository orderRepo)
        {
            Console.Write("Enter UserId: ");
            int userId = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter OrderId: ");
            int orderId = Convert.ToInt32(Console.ReadLine());

            orderRepo.CancelOrder(userId, orderId);
            Console.WriteLine("Order cancelled successfully.");
        }

        // Method to get all products
        static void GetAllProducts(IOrderManagementRepository orderRepo)
        {
            List<Product> products = orderRepo.GetAllProducts();
            Console.WriteLine("\nAll Products:");
            foreach (var product in products)
            {
                Console.WriteLine($"ProductId: {product.ProductId}, Name: {product.ProductName}, Price: {product.Price}, Stock: {product.QuantityInStock}");
            }
        }

        // Method to get orders placed by a user
        static void GetOrderByUser(IOrderManagementRepository orderRepo)
        {
            Console.Write("Enter UserId: ");
            int userId = Convert.ToInt32(Console.ReadLine());

            User user = new User(userId, "", "", "User");

            List<Product> userOrders = orderRepo.GetOrderByUser(user);
            Console.WriteLine("\nOrders placed by user:");
            foreach (var product in userOrders)
            {
                Console.WriteLine($"ProductId: {product.ProductId}, Name: {product.ProductName}, Price: {product.Price}");
            }
        }
    }
}
