﻿using Microsoft.EntityFrameworkCore;
using TesouroAzulAPI.Models;

namespace TesouroAzulAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }



        public DbSet<Usuario> Usuarios { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // Aqui pode realizar configurações adicionais, como definir chaves primárias compostas, etc.
        }
    }
}
