using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PreClinic.Migrations
{
    /// <inheritdoc />
    public partial class AddRelations : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "BranchId",
                table: "DoctorAppointmentSetups",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "DepartmentId",
                table: "DoctorAppointmentSetups",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DoctorAppointmentSetups_BranchId",
                table: "DoctorAppointmentSetups",
                column: "BranchId");

            migrationBuilder.CreateIndex(
                name: "IX_DoctorAppointmentSetups_DepartmentId",
                table: "DoctorAppointmentSetups",
                column: "DepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_DoctorAppointmentSetups_DoctorId",
                table: "DoctorAppointmentSetups",
                column: "DoctorId");

            migrationBuilder.AddForeignKey(
                name: "FK_DoctorAppointmentSetups_Branches_BranchId",
                table: "DoctorAppointmentSetups",
                column: "BranchId",
                principalTable: "Branches",
                principalColumn: "branchId");

            migrationBuilder.AddForeignKey(
                name: "FK_DoctorAppointmentSetups_Department_DepartmentId",
                table: "DoctorAppointmentSetups",
                column: "DepartmentId",
                principalTable: "Department",
                principalColumn: "departmentId");

            migrationBuilder.AddForeignKey(
                name: "FK_DoctorAppointmentSetups_Doctors_DoctorId",
                table: "DoctorAppointmentSetups",
                column: "DoctorId",
                principalTable: "Doctors",
                principalColumn: "doctorId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DoctorAppointmentSetups_Branches_BranchId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropForeignKey(
                name: "FK_DoctorAppointmentSetups_Department_DepartmentId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropForeignKey(
                name: "FK_DoctorAppointmentSetups_Doctors_DoctorId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropIndex(
                name: "IX_DoctorAppointmentSetups_BranchId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropIndex(
                name: "IX_DoctorAppointmentSetups_DepartmentId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropIndex(
                name: "IX_DoctorAppointmentSetups_DoctorId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropColumn(
                name: "BranchId",
                table: "DoctorAppointmentSetups");

            migrationBuilder.DropColumn(
                name: "DepartmentId",
                table: "DoctorAppointmentSetups");
        }
    }
}
