using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PreClinic.Migrations
{
    /// <inheritdoc />
    public partial class ChnagedSetupsTableeee : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "ToTime",
                table: "DoctorAppointmentSetups",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(TimeSpan),
                oldType: "time",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "FromTime",
                table: "DoctorAppointmentSetups",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(TimeSpan),
                oldType: "time",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "BreakOut",
                table: "DoctorAppointmentSetups",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(TimeSpan),
                oldType: "time",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "BreakIn",
                table: "DoctorAppointmentSetups",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(TimeSpan),
                oldType: "time",
                oldNullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<TimeSpan>(
                name: "ToTime",
                table: "DoctorAppointmentSetups",
                type: "time",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<TimeSpan>(
                name: "FromTime",
                table: "DoctorAppointmentSetups",
                type: "time",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<TimeSpan>(
                name: "BreakOut",
                table: "DoctorAppointmentSetups",
                type: "time",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<TimeSpan>(
                name: "BreakIn",
                table: "DoctorAppointmentSetups",
                type: "time",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);
        }
    }
}
