using FluentMigrator;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FluentMigrator.Infrastructure;

namespace Migrations._201706
{
    [Migration(201706071414)]
    public class Migration_201706071414 : Migration
    {
        public override void Down()
        {
            Execute.Script(@"SqlScripts\2017-06\DownInitialDbRelations20170607.sql");
        }

        public override void Up()
        {
            Execute.Script(@"SqlScripts\2017-06\UpInitialDbRelations20170607.sql");
        }
    }
}
