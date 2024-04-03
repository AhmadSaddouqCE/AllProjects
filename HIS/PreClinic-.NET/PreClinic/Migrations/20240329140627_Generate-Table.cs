using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PreClinic.Migrations
{
    /// <inheritdoc />
    public partial class GenerateTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Doctors",
                columns: table => new
                {
                    doctorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    doctorNameE1 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorNameE2 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorNameE3 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorNameE4 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorNameA1 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorNameA2 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorNameA3 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorNameA4 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    AddressE = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AddressA = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    dateOfBirth = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Gender = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    userName = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Password = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Doctors", x => x.doctorId);
                });

            migrationBuilder.CreateTable(
                name: "SystemLookupsCategory",
                columns: table => new
                {
                    CategoryId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    categoryCode = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    categoryNameE = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    categoryNameA = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SystemLookupsCategory", x => x.CategoryId);
                });

            migrationBuilder.CreateTable(
                name: "DoctorAppointmentSetups",
                columns: table => new
                {
                    AppointmentSetupId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DoctorId = table.Column<int>(type: "int", nullable: true),
                    DayOfWeek = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    StartTime = table.Column<TimeSpan>(type: "time", nullable: true),
                    EndTime = table.Column<TimeSpan>(type: "time", nullable: true),
                    BreakStartTime = table.Column<TimeSpan>(type: "time", nullable: true),
                    BreakEndTime = table.Column<TimeSpan>(type: "time", nullable: true),
                    duartionInMinute = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DoctorAppointmentSetups", x => x.AppointmentSetupId);
                    table.ForeignKey(
                        name: "FK_DoctorAppointmentSetups_Doctors_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "Doctors",
                        principalColumn: "doctorId");
                });

            migrationBuilder.CreateTable(
                name: "Patients",
                columns: table => new
                {
                    PateintId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    patientNameE1 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    patientNameE2 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    patientNameE3 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    patientNameE4 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    patientNameA1 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    patientNameA2 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    patientNameA3 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    patientNameA4 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    AddressE = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AddressA = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    dateOfBirth = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Gender = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    doctorId = table.Column<int>(type: "int", nullable: true),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Patients", x => x.PateintId);
                    table.ForeignKey(
                        name: "FK_Patients_Doctors_doctorId",
                        column: x => x.doctorId,
                        principalTable: "Doctors",
                        principalColumn: "doctorId",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateTable(
                name: "SystemLookups",
                columns: table => new
                {
                    LookupId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    categoryId = table.Column<int>(type: "int", nullable: true),
                    lookupNameE = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    lookupNameA = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SystemLookups", x => x.LookupId);
                    table.ForeignKey(
                        name: "FK_SystemLookups_SystemLookupsCategory_categoryId",
                        column: x => x.categoryId,
                        principalTable: "SystemLookupsCategory",
                        principalColumn: "CategoryId",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateTable(
                name: "Branches",
                columns: table => new
                {
                    branchId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    branchNameE = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    branchNameA = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    systemLookupsId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Branches", x => x.branchId);
                    table.ForeignKey(
                        name: "FK_Branches_SystemLookups_systemLookupsId",
                        column: x => x.systemLookupsId,
                        principalTable: "SystemLookups",
                        principalColumn: "LookupId",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateTable(
                name: "Department",
                columns: table => new
                {
                    departmentId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    departmentNameE = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    departmentNameA = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    systemLookupsId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Department", x => x.departmentId);
                    table.ForeignKey(
                        name: "FK_Department_SystemLookups_systemLookupsId",
                        column: x => x.systemLookupsId,
                        principalTable: "SystemLookups",
                        principalColumn: "LookupId",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateTable(
                name: "DoctorBranches",
                columns: table => new
                {
                    doctorId = table.Column<int>(type: "int", nullable: false),
                    branchId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DoctorBranches", x => new { x.doctorId, x.branchId });
                    table.ForeignKey(
                        name: "FK_DoctorBranches_Branches_branchId",
                        column: x => x.branchId,
                        principalTable: "Branches",
                        principalColumn: "branchId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DoctorBranches_Doctors_doctorId",
                        column: x => x.doctorId,
                        principalTable: "Doctors",
                        principalColumn: "doctorId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DepartmentBranches",
                columns: table => new
                {
                    departmentId = table.Column<int>(type: "int", nullable: false),
                    branchId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DepartmentBranches", x => new { x.departmentId, x.branchId });
                    table.ForeignKey(
                        name: "FK_DepartmentBranches_Branches_branchId",
                        column: x => x.branchId,
                        principalTable: "Branches",
                        principalColumn: "branchId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DepartmentBranches_Department_departmentId",
                        column: x => x.departmentId,
                        principalTable: "Department",
                        principalColumn: "departmentId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DoctorDepartments",
                columns: table => new
                {
                    doctorId = table.Column<int>(type: "int", nullable: false),
                    departmentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DoctorDepartments", x => new { x.doctorId, x.departmentId });
                    table.ForeignKey(
                        name: "FK_DoctorDepartments_Department_departmentId",
                        column: x => x.departmentId,
                        principalTable: "Department",
                        principalColumn: "departmentId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DoctorDepartments_Doctors_doctorId",
                        column: x => x.doctorId,
                        principalTable: "Doctors",
                        principalColumn: "doctorId",
                        onDelete: ReferentialAction.Cascade);
                });

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

            migrationBuilder.CreateIndex(
                name: "IX_Branches_systemLookupsId",
                table: "Branches",
                column: "systemLookupsId");

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
                name: "IX_Department_systemLookupsId",
                table: "Department",
                column: "systemLookupsId");

            migrationBuilder.CreateIndex(
                name: "IX_DepartmentBranches_branchId",
                table: "DepartmentBranches",
                column: "branchId");

            migrationBuilder.CreateIndex(
                name: "IX_DoctorAppointmentSetups_DoctorId",
                table: "DoctorAppointmentSetups",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_DoctorBranches_branchId",
                table: "DoctorBranches",
                column: "branchId");

            migrationBuilder.CreateIndex(
                name: "IX_DoctorDepartments_departmentId",
                table: "DoctorDepartments",
                column: "departmentId");

            migrationBuilder.CreateIndex(
                name: "IX_Doctors_Email",
                table: "Doctors",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Doctors_Phone",
                table: "Doctors",
                column: "Phone",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Doctors_userName",
                table: "Doctors",
                column: "userName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Patients_doctorId",
                table: "Patients",
                column: "doctorId");

            migrationBuilder.CreateIndex(
                name: "IX_Patients_Email",
                table: "Patients",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Patients_Phone",
                table: "Patients",
                column: "Phone",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_SystemLookups_categoryId",
                table: "SystemLookups",
                column: "categoryId");

            migrationBuilder.CreateIndex(
                name: "IX_SystemLookups_lookupNameA",
                table: "SystemLookups",
                column: "lookupNameA",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_SystemLookups_lookupNameE",
                table: "SystemLookups",
                column: "lookupNameE",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_SystemLookupsCategory_categoryCode",
                table: "SystemLookupsCategory",
                column: "categoryCode",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_SystemLookupsCategory_categoryNameA",
                table: "SystemLookupsCategory",
                column: "categoryNameA",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_SystemLookupsCategory_categoryNameE",
                table: "SystemLookupsCategory",
                column: "categoryNameE",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DepartmentBranches");

            migrationBuilder.DropTable(
                name: "DoctorAppointmentSetups");

            migrationBuilder.DropTable(
                name: "DoctorBranches");

            migrationBuilder.DropTable(
                name: "DoctorDepartments");

            migrationBuilder.DropTable(
                name: "Patients");

            migrationBuilder.DropTable(
                name: "Branches");

            migrationBuilder.DropTable(
                name: "Department");

            migrationBuilder.DropTable(
                name: "Doctors");

            migrationBuilder.DropTable(
                name: "SystemLookups");

            migrationBuilder.DropTable(
                name: "SystemLookupsCategory");
        }
    }
}
