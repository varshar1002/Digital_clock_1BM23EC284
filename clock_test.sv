`timescale 1ns/1ps

program clock_test (clock_if.TB vif);

    // -------------------------
    // Functional Coverage
    // -------------------------
    covergroup cg @(posedge vif.clk);

        cp_seconds : coverpoint vif.seconds {
            bins sec_vals[] = {[0:59]};
            bins sec_rollover = (59 => 0);
        }

        cp_minutes : coverpoint vif.minutes {
            bins min_vals[] = {[0:59]};
            bins min_rollover = (59 => 0);
        }

        cross cp_seconds, cp_minutes;

    endgroup

    cg coverage_inst = new();

    // -------------------------
    // Assertions (CORRECTED)
    // -------------------------
    property sec_limit;
        @(posedge vif.clk)
        disable iff (vif.reset)
        vif.seconds inside {[0:59]};
    endproperty

    property min_limit;
        @(posedge vif.clk)
        disable iff (vif.reset)
        vif.minutes inside {[0:59]};
    endproperty

    assert property (sec_limit)
        else $error("Seconds exceeded 59!");

    assert property (min_limit)
        else $error("Minutes exceeded 59!");

    // -------------------------
    // Stimulus
    // -------------------------
    initial begin

        // Initial reset
        vif.reset = 1;
        repeat (2) @(posedge vif.clk);
        vif.reset = 0;

        // Run long enough for full rollover
        repeat (3700) @(posedge vif.clk);

        // Apply reset again
        vif.reset = 1;
        repeat (2) @(posedge vif.clk);
        vif.reset = 0;

        repeat (200) @(posedge vif.clk);

        $display("Simulation Completed Successfully.");
        $finish;
    end

endprogram
