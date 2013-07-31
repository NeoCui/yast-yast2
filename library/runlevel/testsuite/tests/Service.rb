# encoding: utf-8

# ***************************************************************************
#
# Copyright (c) 2002 - 2012 Novell, Inc.
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of version 2 of the GNU General Public License as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, contact Novell, Inc.
#
# To contact Novell about this file by physical or electronic mail,
# you may find current contact information at www.novell.com
#
# ***************************************************************************
module Yast
  class ServiceClient < Client
    def main
      Yast.include self, "testsuite.rb"

      TESTSUITE_INIT([{ "target" => { "tmpdir" => "/tmp" } }, {}, {}], nil)

      Yast.import "Service"

      @EXEC = {
        "target"  => {
          "bash"        => 0,
          "bash_output" => { "exit" => 0, "stdout" => "", "stderr" => "" }
        },
        "process" => { "start_shell" => 123, "release" => true }
      }

      @READ = {
        "init"    => { "scripts" => { "exists" => true } },
        "target"  => { "stat" => { "isreg" => true } },
        "process" => { "running" => false, "status" => 0 }
      }

      TEST(lambda { Service.RunInitScriptWithTimeOut("aaa", "start") }, [
        @READ,
        {},
        @EXEC
      ], nil)

      nil
    end
  end
end

Yast::ServiceClient.new.main
