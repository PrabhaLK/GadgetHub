using System.Collections.Generic;
using System.ServiceModel;

namespace GadgetHub.Service
{
    // This interface defines the contract for the GadgetHub service, which includes methods for user registration.
    // The methods are decorated with OperationContract to indicate that they can be called by clients.
    [ServiceContract]
    public interface IGadgetHubService
    {
        [OperationContract]
        bool RegisterUser(string firstName, string lastName, string phoneNumber, string username, string password, string email, string role);

        [OperationContract]
        UserDTO Login(string email, string password);

        [OperationContract]
        List<Category> GetCategories();

        [OperationContract]
        List<ProductDTO> GetProducts(string searchTerm, int[] categoryIds);

        [OperationContract]
        void AddToCart(int userId, int productId, int qty);

        [OperationContract]
        int GetCartItemCount(int userId);

        [OperationContract]
        List<CartItemDTO> GetCartItems(int userId);

        [OperationContract]
        void UpdateCartItemQty(int userId, int productId, int qtyChange);

        [OperationContract]
        void RemoveCartItem(int userId, int productId);

        [OperationContract]
        bool PlaceOrder(int userId, string deliveryAddress);

        //Admin Functions
        [OperationContract]
        List<UserDTO> GetUsers(string roleFilter, string searchQuery);

        [OperationContract]
        void ToggleUserStatus(int userId);

        [OperationContract]
        List<QuotationDTO> GetAllQuotations();

        [OperationContract]
        List<ProductDTO> GetAllProducts(string searchTerm, int[] categoryIds, int? isActive);

        [OperationContract]
        List<OrderDTO> GetAllOrders();

        [OperationContract]
        List<ContactMessageDTO> GetAllContactMessages();

        [OperationContract]
        List<OrderDTO> GetOrdersByUserId(int userId);

        [OperationContract]
        List<OrderDTO> GetOrdersForDistributor(int distributorId);

        [OperationContract]
        bool UpdateOrderStatus(int orderId, string newStatus);

        [OperationContract]
        List<QuotationDTO> GetQuotationsByDistributor(int distributorId);

        [OperationContract]
        bool UpdateQuotationItem(int quotationId, int productId, int quantity, decimal price);

        [OperationContract]
        ContactMessageDTO[] GetMessagesByUser(int userId);
        

    }
}

