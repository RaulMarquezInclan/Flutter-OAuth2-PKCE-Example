using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using InventoryService.Models;
using InventoryService.DB;
using System;

namespace InventoryService.Controllers
{
    [AllowAnonymous]
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : AuthController
    {
        private readonly InventoryContext _context;

        public ProductsController(InventoryContext context) => _context = context;

        [HttpGet]
        public async Task<Response> GetProducts()
        {
            try
            {
                if (Response.Success) Response.Products = await _context.Products.ToListAsync();
            }
            catch (Exception)
            {
                throw;
            }

            return Response;
        }
    }
}
