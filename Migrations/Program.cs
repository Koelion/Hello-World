
using FluentMigrator.Runner.Processors.SqlServer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;


namespace Migrations
{
    class Program
    {

        private static void Main(string[] args)
        {
            Migrator migrator = new Migrator();
            migrator.MigrateUp();
        }

    }
}
