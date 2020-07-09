using System.Collections.Generic;

namespace InventoryService.Models
{
    public class Response
    {
        public Response()
        {
            Products = new List<Products>();
        }
        public bool Success { get; set; }
        public int HttpCode { get; set; }
        public OktaTokenValidityResponse OktaResponse { get; set; }
        public List<Products> Products { get; set; }
        public string Message { get; set; }
    }
}
