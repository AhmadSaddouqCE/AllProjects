using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PreClinic.Migrations
{
    /// <inheritdoc />
    public partial class UpdateValidation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Department_departmentNameA",
                table: "Department");

            migrationBuilder.DropIndex(
                name: "IX_Department_departmentNameE",
                table: "Department");

            migrationBuilder.DropIndex(
                name: "IX_Branches_branchNameA",
                table: "Branches");

            migrationBuilder.DropIndex(
                name: "IX_Branches_branchNameE",
                table: "Branches");

            migrationBuilder.AlterColumn<string>(
                name: "departmentNameE",
                table: "Department",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "departmentNameA",
                table: "Department",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "branchNameE",
                table: "Branches",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "branchNameA",
                table: "Branches",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Department_departmentNameA",
                table: "Department",
                column: "departmentNameA",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Department_departmentNameE",
                table: "Department",
                column: "departmentNameE",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Branches_branchNameA",
                table: "Branches",
                column: "branchNameA",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Branches_branchNameE",
                table: "Branches",
                column: "branchNameE",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Department_departmentNameA",
                table: "Department");

            migrationBuilder.DropIndex(
                name: "IX_Department_departmentNameE",
                table: "Department");

            migrationBuilder.DropIndex(
                name: "IX_Branches_branchNameA",
                table: "Branches");

            migrationBuilder.DropIndex(
                name: "IX_Branches_branchNameE",
                table: "Branches");

            migrationBuilder.AlterColumn<string>(
                name: "departmentNameE",
                table: "Department",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.AlterColumn<string>(
                name: "departmentNameA",
                table: "Department",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.AlterColumn<string>(
                name: "branchNameE",
                table: "Branches",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.AlterColumn<string>(
                name: "branchNameA",
                table: "Branches",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.CreateIndex(
                name: "IX_Department_departmentNameA",
                table: "Department",
                column: "departmentNameA",
                unique: true,
                filter: "[departmentNameA] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Department_departmentNameE",
                table: "Department",
                column: "departmentNameE",
                unique: true,
                filter: "[departmentNameE] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Branches_branchNameA",
                table: "Branches",
                column: "branchNameA",
                unique: true,
                filter: "[branchNameA] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Branches_branchNameE",
                table: "Branches",
                column: "branchNameE",
                unique: true,
                filter: "[branchNameE] IS NOT NULL");
        }
    }
}
