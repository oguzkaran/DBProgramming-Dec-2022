using Newtonsoft.Json;
using System;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace CSD.Extensions.Net.Http
{
    public static class HttpClientExtensions
    {
        public static async Task<T> GetJsonAsync<T>(this HttpClient httpClient, string url, Func<HttpResponseMessage, Task<T>> func)
        {
            var httpResponse = await httpClient.GetAsync(url);

            return await func(httpResponse);
        }

        public static async Task<T> GetJsonAsync<T>(this HttpClient httpClient, string url, Func<HttpResponseMessage, Task<T>> func, params Tuple<string, string>[] requestParams)
        {
            var reqParams = requestParams.Select(t => $"{t.Item1}={t.Item2}").Aggregate("", (pi1, pi2) => $"{pi1}&{pi2}");

            url += $"?{reqParams}";

            return await GetJsonAsync<T>(httpClient, url, func);
        }

        public static async Task<T> GetJsonSuccessAsync<T>(this HttpClient httpClient, string url, string errMsg)
        {
            var httpResponse = await httpClient.GetAsync(url);

            if (!httpResponse.IsSuccessStatusCode)
                throw new HttpRequestException(errMsg);

            var content = await httpResponse.Content.ReadAsStringAsync();

            var t = JsonConvert.DeserializeObject<T>(content);

            return t;
        }

        public static async Task<T> GetJsonSuccessAsync<T>(this HttpClient httpClient, string url, string errMsg, params Tuple<string, string> [] requestParams)
        {
            var reqParams = requestParams.Select(t => $"{t.Item1}={t.Item2}").Aggregate("", (pi1, pi2) => $"{pi1}&{pi2}");

            url += $"?{reqParams}";

            return await GetJsonSuccessAsync<T>(httpClient, url, errMsg);
        }

        public static async Task<T> PostJsonWithResultSuccessAsync<T>(this HttpClient httpClient, string url, T t, string errMsg)
            => await PostJsonWithResultSuccessAsync(httpClient, url, t, Encoding.Default, errMsg);

        public static async Task<T> PostJsonWithResultSuccessAsync<T>(this HttpClient httpClient, string url, T t, Encoding encoding, string errMsg)
        {
            var httpResponse = await PostJsonSuccessAsync(httpClient, url, t, encoding, errMsg);

            return JsonConvert.DeserializeObject<T>(await httpResponse.Content.ReadAsStringAsync());
        }

        public static async Task<HttpResponseMessage> PostJsonSuccessAsync<T>(this HttpClient httpClient, string url, T t, string errMsg)
            => await PostJsonSuccessAsync(httpClient, url, t, Encoding.Default, errMsg);

        public static async Task<HttpResponseMessage> PostJsonSuccessAsync<T>(this HttpClient httpClient, string url, T t, Encoding encoding, string errMsg)
        {
            var content = JsonConvert.SerializeObject(t);
            var httpResponse = await httpClient.PostAsync(url, new StringContent(content, encoding, "application/json"));

            if (!httpResponse.IsSuccessStatusCode)
                throw new HttpRequestException(errMsg);

            return httpResponse;
        }

        public static async Task PostJsonAsync<T>(this HttpClient httpClient, string url, T t, Func<HttpResponseMessage, Task> func)
            => await PostJsonAsync(httpClient, url, t, Encoding.Default, func);
        
        public static async Task PostJsonAsync<T>(this HttpClient httpClient, string url, T t, Encoding encoding, Func<HttpResponseMessage, Task> func)
        {
            var content = JsonConvert.SerializeObject(t);
            var httpResponse = await httpClient.PostAsync(url, new StringContent(content, encoding, "application/json"));

            await func(httpResponse);
        }
    }
}
