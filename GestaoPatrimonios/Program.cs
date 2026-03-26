using DotNetEnv;
using GestaoPatrimonios.Applications.Services;
using GestaoPatrimonios.Contexts;
using GestaoPatrimonios.Interfaces;
using GestaoPatrimonios.Repositores;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Carregando o env -> Arquivo env foi criado para esconder nossos dados do banco, sendo uma camada de segurança
Env.Load();

// Pegando a connection string
string connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING");

// Conexão com o banco - Nossa connectionString(conexão com o banco) vem a partir do arquivo env
builder.Services.AddDbContext<GestaoPatrimoniosContext>(options => options.UseSqlServer(connectionString));

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Áreas
builder.Services.AddScoped<IAreaRepository, AreaRepository>();
builder.Services.AddScoped<AreaService>();

// Localizações
builder.Services.AddScoped<ILocalizacaoRepository, LocalizacaoRepository>();
builder.Services.AddScoped<LocalizacaoService>();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
