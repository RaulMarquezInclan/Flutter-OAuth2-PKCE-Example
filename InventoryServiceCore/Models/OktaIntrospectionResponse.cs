using Newtonsoft.Json.Linq;
using System;

namespace InventoryService.Models
{
    public class OktaTokenValidityResponse
    {
        public OktaTokenValidityResponse(string json)
        {
            JObject jObject = JObject.Parse(json);
            Active = (bool)jObject["active"];
            var scopes = (string)jObject["scope"] ?? string.Empty;
            Scopes = GetScopes(scopes);
        }
        public bool Active { get; set; }
        public string[] Scopes { get; set; }

        private string[] GetScopes(string scp)
        {
            var scopes = new string[0];
            if (string.IsNullOrWhiteSpace(scp)) return scopes;

            try
            {
                scopes = scp.Split(' ');
            }
            catch (Exception)
            {
                throw;
            }
            return scopes;
        }
    }
}
