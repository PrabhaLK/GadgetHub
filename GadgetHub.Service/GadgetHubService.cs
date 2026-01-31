using BCrypt.Net;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Runtime.Serialization;
using System.Text;

namespace GadgetHub.Service
{
    [DataContract]
    public class UserDTO
    {
        [DataMember]
        public int Id { get; set; }
        [DataMember]
        public string FirstName { get; set; }
        [DataMember]
        public string LastName { get; set; }
        [DataMember]
        public string PhoneNumber { get; set; }
        [DataMember]
        public string Username { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Role { get; set; }
        [DataMember]
        public bool IsActive { get; set; }  // Add this if you plan to manage activation
    }

    [DataContract]
    public class Category
    {
        [DataMember]
        public int Id { get; set; }

        [DataMember]
        public string Name { get; set; }
    }

    [DataContract]
    public class ProductDTO
    {
        [DataMember]
        public int? Id { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public int? Price { get; set; }
        [DataMember]
        public string Image { get; set; }
        [DataMember]
        public int? Stock { get; set; }
        [DataMember]
        public int? CategoryId { get; set; }
        [DataMember]
        public string CategoryName { get; set; }
        [DataMember]
        public int? DistributorId { get; set; }
        [DataMember]
        public string DistributorName { get; set; }
        [DataMember]
        public int? IsActive { get; set; }
    }

    [DataContract]
    public class CartItemDTO
    {
        [DataMember]
        public int ProductId { get; set; }

        [DataMember]
        public string ProductName { get; set; }

        [DataMember]
        public string Image { get; set; }

        [DataMember]
        public int Price { get; set; }

        [DataMember]
        public int Qty { get; set; }
    }

    // QuotationDTO.cs
    [DataContract]
    public class QuotationDTO
    {
        [DataMember]
        public int? QuotationId { get; set; }

        [DataMember]
        public int? DistributorId { get; set; }

        [DataMember]
        public string DistributorName { get; set; }

        [DataMember]
        public string Status { get; set; }

        [DataMember]
        public DateTime? CreatedAt { get; set; }

        [DataMember]
        public List<QuotationItemDTO> Items { get; set; }
    }

    // QuotationItemDTO.cs
    [DataContract]
    public class QuotationItemDTO
    {
        [DataMember]
        public int ProductId { get; set; }

        [DataMember]
        public string ProductName { get; set; }

        [DataMember]
        public int Quantity { get; set; }

        [DataMember]
        public decimal Price { get; set; }  // price per item

        [IgnoreDataMember]
        public decimal Total => Price * Quantity;  // optional, for convenience
    }

    public class OrderDTO
    {
        [DataMember]
        public int? Id { get; set; }
        [DataMember]
        public int? UserId { get; set; }
        [DataMember]
        public string UserName { get; set; }           // From Users table (e.g., Username)
        [DataMember]
        public int? Total { get; set; }
        [DataMember]
        public string DeliveryAddress { get; set; }
        [DataMember]
        public string Status { get; set; }
        [DataMember]
        public DateTime? CreatedAt { get; set; }
        [DataMember]
        public List<OrderItemDTO> Items { get; set; } = new List<OrderItemDTO>();
    }

    public class OrderItemDTO
    {
        [DataMember]
        public int? ProductId { get; set; }
        [DataMember]
        public string ProductName { get; set; }        // From Product table
        [DataMember]
        public int? Qty { get; set; }
    }

    public class ContactMessageDTO
    {
        [DataMember]
        public int? Id { get; set; }
        [DataMember]
        public DateTime? Timestamp { get; set; }
        [DataMember]
        public string Subject { get; set; }
        [DataMember]
        public string Message { get; set; }
        [DataMember]
        public int? UserId { get; set; }
        [DataMember]
        public string UserName { get; set; } // Username from Users table
    }


    public class GadgetHubService : IGadgetHubService
    {
        private readonly string connectionString =
            @"Server=(localdb)\MSSQLLocalDB;
            Database=GadgetHubDB;
            Trusted_Connection=True;";

        //private readonly string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\SOC\\GadgetHub\\GadgetHubDB.mdf;Integrated Security=True;Connect Timeout=30;Encrypt=False";
        public bool RegisterUser(string firstName, string lastName, string phoneNumber, string username, string password, string email, string role)
        {
            // Hash the password using bcrypt
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);

            //string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\SOC\\GadgetHub\\GadgetHubDB.mdf;Integrated Security=True;Connect Timeout=30;Encrypt=False";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Users (FirstName, LastName, PhoneNumber, Username, Password, Email, Role) VALUES (@FirstName, @LastName, @PhoneNumber, @Username, @Password, @Email, @Role)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", hashedPassword); // Store hashed password
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Role", role);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
        }

        public UserDTO Login(string email, string password)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Email, Password, Role FROM Users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int userId = reader.GetInt32(0);
                        string userEmail = reader.GetString(1);
                        string hashedPassword = reader.GetString(2);
                        string role = reader.GetString(3)?.Trim();

                        if (BCrypt.Net.BCrypt.Verify(password, hashedPassword))
                        {
                            return new UserDTO
                            {
                                Id = userId,
                                Email = userEmail,
                                Role = role
                            };
                        }
                    }
                }
            }
            return null;
        }

        public List<Category> GetCategories()
        {
            List<Category> categories = new List<Category>();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Name FROM Category";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    categories.Add(new Category
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Name = reader["Name"].ToString()
                    });
                }
            }
            return categories;
        }

        public List<ProductDTO> GetProducts(string searchTerm, int[] categoryIds)
        {
            List<ProductDTO> products = new List<ProductDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                StringBuilder queryBuilder = new StringBuilder("SELECT Id, Name, Price, Image, CategoryId FROM Product WHERE IsActive = 1");

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    queryBuilder.Append(" AND Name LIKE @SearchTerm");
                }

                if (categoryIds != null && categoryIds.Length > 0)
                {
                    string ids = string.Join(",", categoryIds);
                    queryBuilder.Append($" AND CategoryId IN ({ids})");
                }

                SqlCommand cmd = new SqlCommand(queryBuilder.ToString(), conn);

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                }

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    products.Add(new ProductDTO
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Name = reader["Name"].ToString(),
                        Price = Convert.ToInt32(reader["Price"]),
                        Image = reader["Image"].ToString(),
                        CategoryId = Convert.ToInt32(reader["CategoryId"])
                    });
                }
            }

            return products;
        }

        public void AddToCart(int userId, int productId, int qty)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "IF EXISTS (SELECT 1 FROM Cart WHERE UserId = @UserId AND ProductId = @ProductId) " +
                               "UPDATE Cart SET Qty = Qty + @Qty WHERE UserId = @UserId AND ProductId = @ProductId " +
                               "ELSE INSERT INTO Cart (UserId, ProductId, Qty) VALUES (@UserId, @ProductId, @Qty)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@Qty", qty);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public int GetCartItemCount(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(SUM(Qty), 0) FROM Cart WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                conn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public List<CartItemDTO> GetCartItems(int userId)
        {
            List<CartItemDTO> cartItems = new List<CartItemDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT c.ProductId, p.Name AS ProductName, p.Image, p.Price, c.Qty
                         FROM Cart c
                         JOIN Product p ON c.ProductId = p.Id
                         WHERE c.UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    cartItems.Add(new CartItemDTO
                    {
                        ProductId = Convert.ToInt32(reader["ProductId"]),
                        ProductName = reader["ProductName"].ToString(),
                        Image = reader["Image"].ToString(),
                        Price = Convert.ToInt32(reader["Price"]),
                        Qty = Convert.ToInt32(reader["Qty"])
                    });
                }
            }

            return cartItems;
        }

        public void UpdateCartItemQty(int userId, int productId, int qtyChange)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Cart SET Qty = Qty + @QtyChange WHERE UserId = @UserId AND ProductId = @ProductId;
                         DELETE FROM Cart WHERE UserId = @UserId AND ProductId = @ProductId AND Qty <= 0;";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@QtyChange", qtyChange);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void RemoveCartItem(int userId, int productId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Cart WHERE UserId = @UserId AND ProductId = @ProductId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public bool PlaceOrder(int userId, string deliveryAddress)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // 1. Calculate total from cart
                    string totalQuery = "SELECT SUM(p.Price * c.Qty) FROM Cart c JOIN Product p ON c.ProductId = p.Id WHERE c.UserId = @UserId";
                    SqlCommand totalCmd = new SqlCommand(totalQuery, conn, transaction);
                    totalCmd.Parameters.AddWithValue("@UserId", userId);

                    int total = Convert.ToInt32(totalCmd.ExecuteScalar());

                    // 2. Insert Order
                    string insertOrderQuery = "INSERT INTO [Order] (UserId, Total, DeliveryAddress, Status, CreatedAt) VALUES (@UserId, @Total, @DeliveryAddress, 'Pending', GETDATE()); SELECT SCOPE_IDENTITY();";
                    SqlCommand orderCmd = new SqlCommand(insertOrderQuery, conn, transaction);
                    orderCmd.Parameters.AddWithValue("@UserId", userId);
                    orderCmd.Parameters.AddWithValue("@Total", total);
                    orderCmd.Parameters.AddWithValue("@DeliveryAddress", deliveryAddress);

                    int orderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                    // 3. Insert Order_Items
                    string getCartItemsQuery = "SELECT ProductId, Qty FROM Cart WHERE UserId = @UserId";
                    SqlCommand cartCmd = new SqlCommand(getCartItemsQuery, conn, transaction);
                    cartCmd.Parameters.AddWithValue("@UserId", userId);

                    SqlDataReader reader = cartCmd.ExecuteReader();
                    List<Tuple<int, int>> cartItems = new List<Tuple<int, int>>();
                    while (reader.Read())
                    {
                        cartItems.Add(new Tuple<int, int>(
                            Convert.ToInt32(reader["ProductId"]),
                            Convert.ToInt32(reader["Qty"])));
                    }
                    reader.Close();

                    foreach (var item in cartItems)
                    {
                        string insertOrderItemQuery = "INSERT INTO Order_Items (OrderId, ProductId, Qty) VALUES (@OrderId, @ProductId, @Qty)";
                        SqlCommand orderItemCmd = new SqlCommand(insertOrderItemQuery, conn, transaction);
                        orderItemCmd.Parameters.AddWithValue("@OrderId", orderId);
                        orderItemCmd.Parameters.AddWithValue("@ProductId", item.Item1);
                        orderItemCmd.Parameters.AddWithValue("@Qty", item.Item2);

                        orderItemCmd.ExecuteNonQuery();
                    }

                    // 4. Clear Cart
                    string clearCartQuery = "DELETE FROM Cart WHERE UserId = @UserId";
                    SqlCommand clearCartCmd = new SqlCommand(clearCartQuery, conn, transaction);
                    clearCartCmd.Parameters.AddWithValue("@UserId", userId);
                    clearCartCmd.ExecuteNonQuery();

                    transaction.Commit();
                    return true;
                }
                catch
                {
                    transaction.Rollback();
                    return false;
                }
            }
        }

        //Admin Functions
        public List<UserDTO> GetUsers(string roleFilter = null, string searchQuery = null)
        {
            List<UserDTO> users = new List<UserDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, FirstName, LastName, PhoneNumber, Username, Email, Role, IsActive FROM Users WHERE 1=1";

                if (!string.IsNullOrEmpty(roleFilter))
                    query += " AND Role = @Role";

                if (!string.IsNullOrEmpty(searchQuery))
                {
                    query += @" AND (
                FirstName LIKE @Search OR
                LastName LIKE @Search OR
                Username LIKE @Search OR
                Email LIKE @Search OR
                CAST(Id AS VARCHAR) LIKE @Search
            )";
                }

                SqlCommand cmd = new SqlCommand(query, conn);
                if (!string.IsNullOrEmpty(roleFilter))
                    cmd.Parameters.AddWithValue("@Role", roleFilter);

                if (!string.IsNullOrEmpty(searchQuery))
                    cmd.Parameters.AddWithValue("@Search", $"%{searchQuery}%");

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        users.Add(new UserDTO
                        {
                            Id = reader.GetInt32(0),
                            FirstName = reader.GetString(1),
                            LastName = reader.GetString(2),
                            PhoneNumber = reader.GetString(3),
                            Username = reader.GetString(4),
                            Email = reader.GetString(5),
                            Role = reader.GetString(6),
                            IsActive = reader.GetBoolean(7)
                        });
                    }
                }
            }

            return users;
        }

        public void ToggleUserStatus(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get current status
                string getQuery = "SELECT IsActive FROM Users WHERE Id = @Id";
                SqlCommand getCmd = new SqlCommand(getQuery, conn);
                getCmd.Parameters.AddWithValue("@Id", userId);

                bool currentStatus = (bool)getCmd.ExecuteScalar();

                // Toggle status
                string updateQuery = "UPDATE Users SET IsActive = @NewStatus WHERE Id = @Id";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@Id", userId);
                updateCmd.Parameters.AddWithValue("@NewStatus", !currentStatus);

                updateCmd.ExecuteNonQuery();
            }
        }

        public List<QuotationDTO> GetAllQuotations()
        {
            List<QuotationDTO> quotations = new List<QuotationDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get quotation headers
                string qQuery = @"
                    SELECT 
                        q.Id, 
                        q.DistributorId, 
                        q.Status, 
                        q.CreatedAt,
                        u.Username
                    FROM Quotation q
                    LEFT JOIN Users u ON q.DistributorId = u.Id";
                using (SqlCommand cmd = new SqlCommand(qQuery, conn))
                //using (SqlDataReader reader = cmd.ExecuteReader())
                //{
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            quotations.Add(new QuotationDTO
                            {
                                QuotationId = reader.IsDBNull(0) ? (int?)null : reader.GetInt32(0),
                                DistributorId = reader.IsDBNull(1) ? (int?)null : reader.GetInt32(1),
                                Status = reader.IsDBNull(2) ? null : reader.GetString(2),
                                CreatedAt = reader.IsDBNull(3) ? (DateTime?)null : reader.GetDateTime(3),
                                DistributorName = reader.IsDBNull(4) ? null : reader.GetString(4),
                                Items = new List<QuotationItemDTO>()
                            });
                        }
                    }
                    else
                    {
                        // Add a placeholder row with nulls
                        quotations.Add(new QuotationDTO
                        {
                            QuotationId = null,
                            DistributorId = null,
                            Status = null,
                            CreatedAt = null,
                            DistributorName = null,
                            Items = new List<QuotationItemDTO>()
                        });
                    }
                }

                // Get quotation items
                foreach (var quote in quotations)
                {
                    if (!quote.QuotationId.HasValue)
                    {
                        // Skip placeholder rows when the quotations table is empty
                        continue;
                    }
                    string iQuery = @"SELECT qi.ProductId, p.Name, qi.Qty, qi.Price 
                      FROM QuotationItem qi 
                      JOIN Product p ON qi.ProductId = p.Id
                      WHERE qi.QuotationId = @QuotationId";

                    using (SqlCommand cmd = new SqlCommand(iQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@QuotationId", quote.QuotationId.Value);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                quote.Items.Add(new QuotationItemDTO
                                {
                                    ProductId = reader.GetInt32(0),
                                    ProductName = reader.GetString(1),
                                    Quantity = reader.GetInt32(2),
                                    Price = reader.GetDecimal(3)
                                });
                            }
                        }
                    }
                }
            }

            return quotations;
        }

        public List<ProductDTO> GetAllProducts(string searchTerm = null, int[] categoryIds = null, int? isActive = null)
        {
            List<ProductDTO> products = new List<ProductDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                StringBuilder query = new StringBuilder(@"
            SELECT 
                p.Id, p.Name, p.Description, p.Price, p.Image, p.Stock,
                p.CategoryId, c.Name AS CategoryName,
                p.DistributorId, u.Username AS DistributorName,
                p.IsActive
            FROM Product p
            LEFT JOIN Category c ON p.CategoryId = c.Id
            LEFT JOIN Users u ON p.DistributorId = u.Id
            WHERE 1=1 ");

                if (!string.IsNullOrEmpty(searchTerm))
                    query.Append(" AND p.Name LIKE @SearchTerm ");

                if (categoryIds != null && categoryIds.Length > 0)
                    query.Append($" AND p.CategoryId IN ({string.Join(",", categoryIds)}) ");

                if (isActive.HasValue)
                    query.Append(" AND p.IsActive = @IsActive ");

                using (SqlCommand cmd = new SqlCommand(query.ToString(), conn))
                {
                    if (!string.IsNullOrEmpty(searchTerm))
                        cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                    if (isActive.HasValue)
                        cmd.Parameters.AddWithValue("@IsActive", isActive.Value);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            products.Add(new ProductDTO
                            {
                                Id = reader.IsDBNull(0) ? (int?)null : reader.GetInt32(0),
                                Name = reader.IsDBNull(1) ? null : reader.GetString(1),
                                Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                                Price = reader.IsDBNull(3) ? (int?)null : reader.GetInt32(3),
                                Image = reader.IsDBNull(4) ? null : reader.GetString(4),
                                Stock = reader.IsDBNull(5) ? (int?)null : reader.GetInt32(5),
                                CategoryId = reader.IsDBNull(6) ? (int?)null : reader.GetInt32(6),
                                CategoryName = reader.IsDBNull(7) ? null : reader.GetString(7),
                                DistributorId = reader.IsDBNull(8) ? (int?)null : reader.GetInt32(8),
                                DistributorName = reader.IsDBNull(9) ? null : reader.GetString(9),
                                IsActive = reader.IsDBNull(10) ? (int?)null : reader.GetInt32(10),
                            });
                        }
                    }
                }
            }

            return products;
        }

        public List<OrderDTO> GetAllOrders()
        {
            List<OrderDTO> orders = new List<OrderDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Step 1: Query orders with user info
                string orderQuery = @"
            SELECT 
                o.Id, o.UserId, u.Username, o.Total, o.DeliveryAddress, o.Status, o.CreatedAt
            FROM [Order] o
            INNER JOIN Users u ON o.UserId = u.Id
            ORDER BY o.CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(orderQuery, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new OrderDTO
                            {
                                Id = reader.GetInt32(0),
                                UserId = reader.GetInt32(1),
                                UserName = reader.IsDBNull(2) ? null : reader.GetString(2),
                                Total = reader.GetInt32(3),
                                DeliveryAddress = reader.GetString(4),
                                Status = reader.GetString(5),
                                CreatedAt = reader.GetDateTime(6),
                                Items = new List<OrderItemDTO>()
                            });
                        }
                    }
                }

                // Step 2: For each order, load order items with product names
                string itemsQuery = @"
            SELECT oi.OrderId, oi.ProductId, p.Name, oi.Qty
            FROM Order_Items oi
            INNER JOIN Product p ON oi.ProductId = p.Id
            WHERE oi.OrderId = @OrderId";

                using (SqlCommand cmd = new SqlCommand(itemsQuery, conn))
                {
                    foreach (var order in orders)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@OrderId", order.Id);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                order.Items.Add(new OrderItemDTO
                                {
                                    ProductId = reader.GetInt32(1),
                                    ProductName = reader.GetString(2),
                                    Qty = reader.GetInt32(3)
                                });
                            }
                        }
                    }
                }
            }

            return orders;
        }

        public List<ContactMessageDTO> GetAllContactMessages()
        {
            List<ContactMessageDTO> messages = new List<ContactMessageDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"
            SELECT 
                cm.Id, cm.Timestamp, cm.Subject, cm.Message, cm.UserId, u.Username
            FROM Contact_Messages cm
            INNER JOIN Users u ON cm.UserId = u.Id
            ORDER BY cm.Timestamp DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            messages.Add(new ContactMessageDTO
                            {
                                Id = reader.GetInt32(0),
                                Timestamp = reader.GetDateTime(1),
                                Subject = reader.GetString(2),
                                Message = reader.GetString(3),
                                UserId = reader.GetInt32(4),
                                UserName = reader.IsDBNull(5) ? null : reader.GetString(5)
                            });
                        }
                    }
                }
            }

            return messages;
        }

        public List<OrderDTO> GetOrdersByUserId(int userId)
        {
            List<OrderDTO> orders = new List<OrderDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get orders for the specific user
                string orderQuery = @"
            SELECT Id, UserId, Total, DeliveryAddress, Status, CreatedAt
            FROM [Order]
            WHERE UserId = @UserId
            ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(orderQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new OrderDTO
                            {
                                Id = reader.GetInt32(0),
                                UserId = reader.GetInt32(1),
                                Total = reader.GetInt32(2),
                                DeliveryAddress = reader.GetString(3),
                                Status = reader.GetString(4),
                                CreatedAt = reader.GetDateTime(5),
                                Items = new List<OrderItemDTO>()
                            });
                        }
                    }
                }

                // Get items for each order
                string itemsQuery = @"
            SELECT oi.OrderId, oi.ProductId, p.Name, oi.Qty
            FROM Order_Items oi
            INNER JOIN Product p ON oi.ProductId = p.Id
            WHERE oi.OrderId = @OrderId";

                using (SqlCommand cmd = new SqlCommand(itemsQuery, conn))
                {
                    foreach (var order in orders)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@OrderId", order.Id);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                order.Items.Add(new OrderItemDTO
                                {
                                    ProductId = reader.GetInt32(1),
                                    ProductName = reader.GetString(2),
                                    Qty = reader.GetInt32(3)
                                });
                            }
                        }
                    }
                }
            }

            return orders;
        }

        public List<OrderDTO> GetOrdersForDistributor(int distributorId)
        {
            List<OrderDTO> orders = new List<OrderDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get orders that have order items with products by this distributor
                string query = @"
            SELECT DISTINCT o.Id, o.UserId, u.Username, o.Total, o.DeliveryAddress, o.Status, o.CreatedAt
            FROM [Order] o
            JOIN Users u ON o.UserId = u.Id
            JOIN Order_Items oi ON o.Id = oi.OrderId
            JOIN Product p ON oi.ProductId = p.Id
            WHERE p.DistributorId = @DistributorId
            ORDER BY o.CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DistributorId", distributorId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new OrderDTO
                            {
                                Id = reader.GetInt32(0),
                                UserId = reader.GetInt32(1),
                                UserName = reader.GetString(2),
                                Total = reader.GetInt32(3),
                                DeliveryAddress = reader.GetString(4),
                                Status = reader.GetString(5),
                                CreatedAt = reader.GetDateTime(6),
                                Items = new List<OrderItemDTO>()
                            });
                        }
                    }
                }

                // Load order items for each order
                foreach (var order in orders)
                {
                    string itemsQuery = @"
                SELECT oi.ProductId, p.Name, oi.Qty
                FROM Order_Items oi
                JOIN Product p ON oi.ProductId = p.Id
                WHERE oi.OrderId = @OrderId";

                    using (SqlCommand cmd = new SqlCommand(itemsQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@OrderId", order.Id);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                order.Items.Add(new OrderItemDTO
                                {
                                    ProductId = reader.GetInt32(0),
                                    ProductName = reader.GetString(1),
                                    Qty = reader.GetInt32(2)
                                });
                            }
                        }
                    }
                }
            }

            return orders;
        }

        public bool UpdateOrderStatus(int orderId, string newStatus)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string updateQuery = "UPDATE [Order] SET Status = @Status WHERE Id = @OrderId";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);

                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0;
                }
            }
        }

        public List<QuotationDTO> GetQuotationsByDistributor(int distributorId)
        {
            var quotations = new List<QuotationDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get quotations for distributor
                string qQuery = @"
                SELECT Id, DistributorId, Status, CreatedAt 
                FROM Quotation
                WHERE DistributorId = @DistributorId";

                using (SqlCommand cmd = new SqlCommand(qQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@DistributorId", distributorId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            quotations.Add(new QuotationDTO
                            {
                                QuotationId = reader.GetInt32(0),
                                DistributorId = reader.GetInt32(1),
                                Status = reader.GetString(2),
                                CreatedAt = reader.GetDateTime(3),
                                Items = new List<QuotationItemDTO>()
                            });
                        }
                    }
                }

                // For each quotation, get its items
                foreach (var quote in quotations)
                {
                    string iQuery = @"
                    SELECT qi.ProductId, p.Name, qi.Qty, qi.Price
                    FROM QuotationItem qi
                    INNER JOIN Product p ON qi.ProductId = p.Id
                    WHERE qi.QuotationId = @QuotationId
                    AND p.DistributorId = @DistributorId";  // ensure only products sold by distributor

                    using (SqlCommand cmd = new SqlCommand(iQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@QuotationId", quote.QuotationId);
                        cmd.Parameters.AddWithValue("@DistributorId", distributorId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                quote.Items.Add(new QuotationItemDTO
                                {
                                    ProductId = reader.GetInt32(0),
                                    ProductName = reader.GetString(1),
                                    Quantity = reader.GetInt32(2),
                                    Price = reader.GetDecimal(3)
                                });
                            }
                        }
                    }
                }
            }

            return quotations;
        }

        public bool UpdateQuotationItem(int quotationId, int productId, int quantity, decimal price)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string updateQuery = @"
                UPDATE QuotationItem
                SET Qty = @Qty,
                    Price = @Price
                WHERE QuotationId = @QuotationId
                  AND ProductId = @ProductId";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Qty", quantity);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@QuotationId", quotationId);
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0;
                }
            }
        }

        public ContactMessageDTO[] GetMessagesByUser(int userId)
        {
            List<ContactMessageDTO> messages = new List<ContactMessageDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"
            SELECT Id, Timestamp, Subject, Message, UserId
            FROM Contact_Messages
            WHERE UserId = @UserId
            ORDER BY Timestamp DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            messages.Add(new ContactMessageDTO
                            {
                                Id = reader.GetInt32(0),
                                Timestamp = reader.GetDateTime(1),
                                Subject = reader.GetString(2),
                                Message = reader.GetString(3),
                                UserId = reader.GetInt32(4)
                            });
                        }
                    }
                }
            }

            return messages.ToArray();
        }


    }
}