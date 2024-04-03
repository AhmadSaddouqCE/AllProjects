using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PreClinic.Migrations
{
    /// <inheritdoc />
    public partial class ChnagedSetupsTableee : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "dayOfWeek",
                table: "DoctorAppointmentSetups",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "dayOfWeek",
                table: "DoctorAppointmentSetups",
                type: "int",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);
        }
    }
}
