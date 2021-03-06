using Microsoft.AspNetCore.Mvc;

namespace SampleApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PersonsController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            var persons = new string[]{
                "Barcelona",
                "Real Madrid",
                "Manchester City",
                "Liverpool",
                "Chelsea"
            };
            return Ok(persons);
        }
    }
}