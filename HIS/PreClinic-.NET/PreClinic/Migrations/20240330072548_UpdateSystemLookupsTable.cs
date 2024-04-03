using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PreClinic.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSystemLookupsTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Branches_SystemLookups_systemLookupsId",
                table: "Branches");

            migrationBuilder.DropForeignKey(
                name: "FK_Department_SystemLookups_systemLookupsId",
                table: "Department");

            migrationBuilder.DropIndex(
                name: "IX_Department_systemLookupsId",
                table: "Department");

            migrationBuilder.DropIndex(
                name: "IX_Branches_systemLookupsId",
                table: "Branches");

            migrationBuilder.DropColumn(
                name: "systemLookupsId",
                table: "Department");

            migrationBuilder.DropColumn(
                name: "systemLookupsId",
                table: "Branches");

            migrationBuilder.AddColumn<int>(
                name: "cardId",
                table: "Patients",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Patients_cardId",
                table: "Patients",
                column: "cardId",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Patients_cardId",
                table: "Patients");

            migrationBuilder.DropColumn(
                name: "cardId",
                table: "Patients");

            migrationBuilder.AddColumn<int>(
                name: "systemLookupsId",
                table: "Department",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "systemLookupsId",
                table: "Branches",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Department_systemLookupsId",
                table: "Department",
                column: "systemLookupsId");

            migrationBuilder.CreateIndex(
                name: "IX_Branches_systemLookupsId",
                table: "Branches",
                column: "systemLookupsId");

            migrationBuilder.AddForeignKey(
                name: "FK_Branches_SystemLookups_systemLookupsId",
                table: "Branches",
                column: "systemLookupsId",
                principalTable: "SystemLookups",
                principalColumn: "LookupId",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_Department_SystemLookups_systemLookupsId",
                table: "Department",
                column: "systemLookupsId",
                principalTable: "SystemLookups",
                principalColumn: "LookupId",
                onDelete: ReferentialAction.SetNull);
        }
    }
}
