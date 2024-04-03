using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PreClinic.Migrations
{
    /// <inheritdoc />
    public partial class ChnagedSetupsTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DoctorAppointmentSetups_Doctors_DoctorId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropIndex(
                name: "IX_DoctorAppointmentSetups_DoctorId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.RenameColumn(
                name: "DayOfWeek",
                table: "DoctorAppointmentSetups",
                newName: "dayOfWeek");

            migrationBuilder.RenameColumn(
                name: "duartionInMinute",
                table: "DoctorAppointmentSetups",
                newName: "DurationInMinutes");

            migrationBuilder.RenameColumn(
                name: "StartTime",
                table: "DoctorAppointmentSetups",
                newName: "ToTime");

            migrationBuilder.RenameColumn(
                name: "EndTime",
                table: "DoctorAppointmentSetups",
                newName: "FromTime");

            migrationBuilder.RenameColumn(
                name: "BreakStartTime",
                table: "DoctorAppointmentSetups",
                newName: "BreakOut");

            migrationBuilder.RenameColumn(
                name: "BreakEndTime",
                table: "DoctorAppointmentSetups",
                newName: "BreakIn");

            migrationBuilder.AlterColumn<int>(
                name: "dayOfWeek",
                table: "DoctorAppointmentSetups",
                type: "int",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "dayOfWeek",
                table: "DoctorAppointmentSetups",
                newName: "DayOfWeek");

            migrationBuilder.RenameColumn(
                name: "ToTime",
                table: "DoctorAppointmentSetups",
                newName: "StartTime");

            migrationBuilder.RenameColumn(
                name: "FromTime",
                table: "DoctorAppointmentSetups",
                newName: "EndTime");

            migrationBuilder.RenameColumn(
                name: "DurationInMinutes",
                table: "DoctorAppointmentSetups",
                newName: "duartionInMinute");

            migrationBuilder.RenameColumn(
                name: "BreakOut",
                table: "DoctorAppointmentSetups",
                newName: "BreakStartTime");

            migrationBuilder.RenameColumn(
                name: "BreakIn",
                table: "DoctorAppointmentSetups",
                newName: "BreakEndTime");

            migrationBuilder.AlterColumn<string>(
                name: "DayOfWeek",
                table: "DoctorAppointmentSetups",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DoctorAppointmentSetups_DoctorId",
                table: "DoctorAppointmentSetups",
                column: "DoctorId");

            migrationBuilder.AddForeignKey(
                name: "FK_DoctorAppointmentSetups_Doctors_DoctorId",
                table: "DoctorAppointmentSetups",
                column: "DoctorId",
                principalTable: "Doctors",
                principalColumn: "doctorId");
        }
    }
}
