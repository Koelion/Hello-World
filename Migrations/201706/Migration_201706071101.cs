using FluentMigrator;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Migrations._20170607
{
    [Migration(201706071101)]
    public class Migration_201706071101 : Migration
    {
        public override void Down()
        {
            Execute.Script(@"SqlScripts\2017-06\DownInitialDb20170607.sql");
        }

        public override void Up()
        {
            Execute.Script(@"SqlScripts\2017-06\UpInitialDb20170607.sql");
        }
    }
}
