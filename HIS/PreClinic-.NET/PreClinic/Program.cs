using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using PreClinic.Data;
using PreClinic.Helper;
using PreClinic.Services;
using System.Text;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddControllersWithViews()
                .AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: "AllowOrigin", builder =>
    {
        builder.WithOrigins("http://localhost:4200").AllowAnyHeader().AllowAnyMethod();
    });
});

builder.Services.AddSingleton(provider =>
{
    var config = new AutoMapper.MapperConfiguration(cfg =>
    {
        cfg.AddProfile<MappingProfiles>();
    });
    return config.CreateMapper();
});

builder.Services.AddScoped<DoctorService>();
builder.Services.AddScoped<PatientService>();
builder.Services.AddScoped<DepartmentService>();
builder.Services.AddScoped<BranchService>();
builder.Services.AddScoped<SystemlookupsService>();
builder.Services.AddScoped<SystemlookupsCategoryService>();
builder.Services.AddScoped<DepartmentsBranhcesService>();
builder.Services.AddScoped<BranchService>();
builder.Services.AddScoped<DepartmentService>();
builder.Services.AddScoped<AppointmentSetupService>();

builder.Services.Configure<FormOptions>(options =>
{
    options.ValueLengthLimit = int.MaxValue;
    options.MultipartBodyLengthLimit = long.MaxValue;
    options.MultipartHeadersLengthLimit = int.MaxValue;
});
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo { Title = "My API", Version = "v1" });

    // Add security definition and requirement for JWT authentication
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Name = "Authorization",
        Description = "Bearer Authentication with JWT Token",
        Type = SecuritySchemeType.Http
    });
    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Id = "Bearer",
                    Type = ReferenceType.SecurityScheme
                }
            },
            new List<string>()
        }
    });

});

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
{
    options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters()
    {
        ValidateActor = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"],
        IssuerSigningKey = new Microsoft.IdentityModel.Tokens.SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]))
    };
});

builder.Services.AddAuthorization();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddDbContext<DataContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("Defualt")).EnableSensitiveDataLogging();

});

var app = builder.Build();
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "PreClinic");
    });
}
app.UseHttpsRedirection();
app.UseCors("AllowOrigin");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.Run();
