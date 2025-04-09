using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TesouroAzulAPI.Data;
using TesouroAzulAPI.Models;

namespace TesouroAzulAPI.Controllers
{
        [Route("api/Usuarios"), ApiController]
        public class UsuarioController : ControllerBase
        {
            private readonly ApplicationDbContext _context;

        // Instanciando o context da ApplicationDbContext para _context
        public UsuarioController(ApplicationDbContext context)
        {
            _context = context;
        }

        // DTOs (Data Transfer Object) para o Http AlterarCamposUsuario 
        public class AtualizarCampoUsuarioDto 
        {
            public string Campo { get; set; } = string.Empty;
            public string NovoValor { get; set; } = string.Empty;

        }


        // POSTs
        // Criar Usuario
        [HttpPost]
        public async Task<IActionResult> CriarUsuario([FromBody] Usuario usuario) 
        {
            if (await _context.Usuarios.AnyAsync(u => u.Email == usuario.Email || u.Cpf == usuario.Cpf ))
            {
                return BadRequest(new {mensagem = "Email ou CPF já cadastrado." });
            }

            _context.Usuarios.Add(usuario);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(BuscarUsuarioPorId), new { id = usuario.Id }, usuario);
        }

        // GETs
        // Buscar Usuarios
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Usuario>>> BuscarUsuarios() 
        {
            return await _context.Usuarios.ToListAsync();
        }

        // Buscar Usuario por ID
        [HttpGet("{id}")]
        public async Task<ActionResult<Usuario>> BuscarUsuarioPorId(int id) 
        {
            var usuario = await _context.Usuarios.FindAsync(id);
            if (usuario == null) return NotFound("Usuario não encontrado.");
            return usuario;
        }

        // PATCHs
        // Atualizar Usuario
        [HttpPatch("{id}/alterar-campo")]
        public async Task<IActionResult> AlterarCamposUsuario(int id, [FromBody] AtualizarCampoUsuarioDto dto)
        {
            // Controller Dinâmico, ou seja, utiliza a classe AtualizarCampoUsuarioDto para qualquer campo e informação que deseja alterar

            // Tratamentos de erro
            var usuario = await _context.Usuarios.FindAsync(id);
            if (usuario == null) return NotFound("Usuario não encontrado.");

            if (string.IsNullOrEmpty(dto.Campo) || string.IsNullOrEmpty(dto.NovoValor))
            {
                return BadRequest("Campo ou Novo Valor não podem ser nulos ou vazios.");
            }

            switch (dto.Campo) 
            {
                case "nome":
                    usuario.Nome = dto.NovoValor;
                    break;
                case "email":
                    usuario.Email = dto.NovoValor;
                    break;
                case "cpf":
                    usuario.Cpf = dto.NovoValor;
                    break;
                case "cnpj":
                    usuario.Cnpj = dto.NovoValor;
                    break;
                case "senha":
                    usuario.Senha = dto.NovoValor;
                    break;
                case "imagem":
                    // preciso adiciar a logica de uma nova imagem
                    return Ok();
                    break;
                case "status":
                    if(bool.TryParse(dto.NovoValor, out bool novoStatus))
                    {
                        usuario.Status = novoStatus;
                    }
                    else
                    {
                        return BadRequest("Novo Valor para Status deve ser um booleano.");
                    }
                    break;
                case "statusAssinatura":
                    if (bool.TryParse(dto.NovoValor, out bool novoStatusAssinatura))
                    {
                        usuario.StatusAssinatura = novoStatusAssinatura;
                    }
                    else
                    {
                        return BadRequest("Novo Valor para Status Assinatura deve ser um booleano.");
                    }
                    break;

                default:
                    return BadRequest("Campo inválido.");
            }

            _context.Usuarios.Update(usuario);
            await _context.SaveChangesAsync();
            return Ok(new { mensagem = "Campo Atualizado com sucesso." , usuario});
        }

        // DELETEs
        // Deletar Usuario
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletarUsuario(int id) 
        {
            var usuario = await _context.Usuarios.FindAsync(id);
            if (usuario == null) return NotFound("Usuario não encontrado."); // Tratamento de erro

            _context.Usuarios.Remove(usuario);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}
