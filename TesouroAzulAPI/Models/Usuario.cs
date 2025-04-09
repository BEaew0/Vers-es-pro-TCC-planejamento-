using Microsoft.AspNetCore.Mvc.Infrastructure;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Numerics;

namespace TesouroAzulAPI.Models
{
    public class Usuario
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required, StringLength(80)]
        public string Nome { get; set; }

        [Required, MaxLength(35), EmailAddress]
        public string Email { get; set; }

        [Required]
        public DateTime DataNascimento { get; set; }

        [Required, StringLength(11)]
        public string Cpf {  get; set; }

        [StringLength(14)]
        public string Cnpj { get; set; }

        [Required, MinLength(8), MaxLength(20)]
        public string Senha { get; set; }
        
        [Column(TypeName = "MEDIUMBLOB")]
        public byte[] Imagem {  get; set; }

        [Required]
        public bool StatusAssinatura {  get; set; } = false;

        [Required]
        public bool Status { get; set; } = false;
        
    }
}
