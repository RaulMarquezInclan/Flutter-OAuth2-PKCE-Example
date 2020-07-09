using InventoryService.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Nito.AsyncEx.Synchronous;
using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace InventoryService.Controllers
{
    public class AuthController : Controller
    {
        public new Response Response = new Response();
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            base.OnActionExecuting(context);
            try
            {
                var clientId = context.HttpContext.Request.Query["client_id"].ToString();
                var authHeader = context.HttpContext.Request.Headers["Authorization"];
                var token = authHeader.First().Split(' ').Last().Trim();

                var validTokenResp = Task.Run(async () => await VerifyTokenValidity(clientId, token)).WaitAndUnwrapException();

                if (validTokenResp.IsSuccessStatusCode)
                {
                    var validTokenRespObj = Task.Run(async () => await GetValidTokenResponseObject(validTokenResp)).WaitAndUnwrapException();

                    if (validTokenRespObj.Active)
                    {
                        if (validTokenRespObj.Scopes.Contains("products"))
                        {
                            Response = new Response
                            {
                                Success = true,
                                HttpCode = (int)validTokenResp.StatusCode,
                                OktaResponse = validTokenRespObj,
                                Products = new List<Products>(),
                                Message = "Products retreival successful"
                            };
                        }
                        else
                        {
                            Response = new Response
                            {
                                Success = false,
                                HttpCode = (int)validTokenResp.StatusCode,
                                OktaResponse = validTokenRespObj,
                                Products = null,
                                Message = "User is not authorized for products retreival"
                            };
                        }
                    }
                    else
                    {
                        Response = new Response
                        {
                            Success = false,
                            HttpCode = (int)validTokenResp.StatusCode,
                            OktaResponse = validTokenRespObj,
                            Products = null,
                            Message = "Invalid Access Token"
                        };
                    }
                }
                else
                {
                    // Server error
                    var httpCode = Int32.Parse(validTokenResp.StatusCode.ToString());
                    Response = new Response
                    {
                        Success = false,
                        HttpCode = httpCode,
                        OktaResponse = null,
                        Products = null,
                        Message = $"Failed Request. HTTP Status Code: ${httpCode}"
                    };
                }
            }
            catch (Exception ex)
            {
                Response = new Response
                {
                    Success = false,
                    HttpCode = -1,
                    OktaResponse = null,
                    Products = null,
                    Message = $"An error has ocurred:\n\n${ex.Message}"
                };
            }
        }

        private async Task<HttpResponseMessage> VerifyTokenValidity(string client_id, string token)
        {
            HttpResponseMessage resp;
            try
            {
                using (var client = new HttpClient())
                {
                    var intUrl = $"https://dev-371167.okta.com/oauth2/default/v1/introspect?client_id={client_id}&token={token}";
                    var request = new HttpRequestMessage(HttpMethod.Post, intUrl);
                    request.Headers.Add("Accept", "application/json");
                    request.Content = new StringContent("", Encoding.UTF8, "application/x-www-form-urlencoded");
                    resp = await client.SendAsync(request);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return resp;
        }

        private async Task<OktaTokenValidityResponse> GetValidTokenResponseObject(HttpResponseMessage respMsg)
        {
            OktaTokenValidityResponse oiro;
            try
            {
                using var responseStream = await respMsg.Content.ReadAsStreamAsync();
                var responseJson = (await JsonSerializer.DeserializeAsync<object>(responseStream)).ToString();
                oiro = new OktaTokenValidityResponse(responseJson);
            }
            catch (Exception)
            {
                throw;
            }

            return oiro;
        }
    
    }
}
