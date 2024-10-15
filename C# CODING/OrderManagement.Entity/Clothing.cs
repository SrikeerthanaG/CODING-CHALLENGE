using OrderManagementSystem.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OrderManagementSystem.Entity
{
    public class Clothing : Product
    {
        public string Size { get; set; }
        public string Color { get; set; }

        public Clothing(int productId, string productName, string description, double price, int quantityInStock, string size, string color)
            : base(productId, productName, description, price, quantityInStock, "Clothing")
        {
            Size = size;
            Color = color;
        }
    }
}
