       identification division.
       program-id. MAFD_Final.
       author. Rolando Agullano.
       date-written. 2020-03-27.
      *Purpose: This program takes an input from a data file, and 
      *performs a process to produce a report, and data validation that 
      *moves Sales, Layaways, and Returns to a respective file.

       environment division.
       input-output section.
       file-control.

            select in-file
                assign to '../../../data/Valid.dat'
                organization is line sequential.

            select sales-layaway-file
                assign to '../../../data/Sales_Layaway.dat'
                organization is line sequential.

           select return-file
                assign to '../../../data/Returns.dat'
                organization is line sequential.

           select report-file
                assign to '../../../data/Report.out'
                organization is line sequential.

       configuration section.

       data division.

       file section.
       fd in-file
          record contains 36 characters
          data record is input-line.

      *Employee record will take input from the dat file
       01 input-line.
           05 il-transaction-code              pic x.
           05 il-transaction-amount            pic 9(5)v99.
           05 il-payment-type                  pic xx.
           05 il-store-number                  pic 99.
           05 il-invoice-number                pic x(9).
           05 il-sku-code                      pic x(15).

       fd sales-layaway-file
           record contains 36 characters
           data record is sales-layaway-line.

      *Print-line will be the main output to the formatted report
       01 sales-layaway-line.
           05 sl-transaction-code              pic x.
           05 sl-transaction-amount            pic 9(5)v99.
           05 sl-payment-type                  pic xx.
           05 sl-store-number                  pic 99.
           05 sl-invoice-number                pic x(9).
           05 sl-sku-code                      pic x(15).

       fd return-file
           record contains 36 characters
           data record is return-line.

      *Grad-line will output 
       01 return-line.
           05 rl-transaction-code              pic x.
           05 rl-transaction-amount            pic 9(5)v99.
           05 rl-payment-type                  pic xx.
           05 rl-store-number                  pic 99.
           05 rl-invoice-number                pic x(9).
           05 rl-sku-code                      pic x(15).

       fd report-file
           record contains 91 characters
           data record is report-line.

      *Grad-line will output 
       01 report-line.
           05 filler                           pic x(91).
           
       working-storage section.

      *Headers For Formatting Purposes:

       01 ws-heading.
           05 filler                           pic x(14) value spaces.
           05 filler                           pic x(53)
            value 
            "Group 7, Final Project Program 2 Counts & Totals Page".
           05 filler                           pic x(15)
            value spaces.
           05 ws-sys-date                      pic 9(6).
           05 filler                           pic x(15)
            value spaces.  
           05 ws-sys-time                      pic 9(8).


       01 ws-heading1.
           05 filler                           pic x(8)
               value "# Of S&L". 
           05 filler                           pic x(3).          
           05 filler                           pic x(16)
               value "S&L AMOUNT TOTAL".
           05 filler                           pic x(3).
           05 filler                           pic x(10)
               value "# OF SALES".
           05 filler                           pic x(3).
           05 filler                           pic x(11)
               value "SALES TOTAL".
           05 filler                           pic x(3).
           05 filler                           pic x(13)
               value "# OF LAYAWAYS".
           05 filler                           pic x(3).
           05 filler                           pic x(14)
               value "LAYAWAYS TOTAL".

       01 ws-output1.
           05 filler                           pic x(3).
           05 ws-sl-total                      pic zzz.
           05 filler                           pic x(5).
           05 ws-sl-total-amount               pic $zzz,zz9.99.
           05 filler                           pic x(11).
           05 ws-sales                         pic zzz.
           05 filler                           pic x(7).
           05 ws-sales-amount                  pic $zzz,zz9.99.
           05 filler                           pic x(8).
           05 ws-layaways                      pic zzz.
           05 filler                           pic x(9).
           05 ws-layaways-amount               pic $zzz,zz9.99.

       01 ws-heading2.
           05 ws-heading-total                 pic x(9)
               value "Totals:  ". 
           05 filler                           pic x(5).          
           05 filler                           pic x(8)
               value "STORE 01".
           05 filler                           pic x(5).
           05 filler                           pic x(8)
               value "STORE 02".
           05 filler                           pic x(5).
           05 filler                           pic x(8)
               value "STORE 03".
           05 filler                           pic x(5).
           05 filler                           pic x(8)
               value "STORE 04".
           05 filler                           pic x(5).
           05 filler                           pic x(8)
               value "STORE 05".
           05 filler                           pic x(5).
           05 filler                           pic x(8)
               value "STORE 12".

       01 ws-output2.
           05 filler                           pic x(11)
               value spaces.
           05 ws-sl-store1                     pic $zzz,zz9.99.
           05 filler                           pic x(2).
           05 ws-sl-store2                     pic $zzz,zz9.99.
           05 filler                           pic x(2).
           05 ws-sl-store3                     pic $zzz,zz9.99.
           05 filler                           pic x(2).
           05 ws-sl-store4                     pic $zzz,zz9.99.
           05 filler                           pic x(2).
           05 ws-sl-store5                     pic $zzz,zz9.99.
           05 filler                           pic x(2).
           05 ws-sl-store6                     pic $zzz,zz9.99.


       01 ws-heading3.
           05 filler                           pic x(12)
               value "% Per Type: ".
           05 filler                           pic x(5).
           05 filler                           pic x(4)
               value "Cash".
           05 filler                           pic x(5).
           05 filler                           pic x(6)
               value "Credit".
           05 filler                           pic x(5).
           05 filler                           pic x(5)
               value "Debit".

       01 ws-output3.
           05 filler                           pic x(17).
           05 filler                           pic x value "%".
           05 ws-cash-perc                     pic z99.
           05 filler                           pic x(5).
           05 filler                           pic x value "%".
           05 ws-credit-perc                   pic z99.
           05 filler                           pic x(7).
           05 filler                           pic x value "%".
           05 ws-debit-perc                    pic z99.

       01 ws-heading4.
           05 filler                           pic x(14)
               value "# Of Returns: ". 
           05 filler                           pic x(8).          
           05 filler                           pic x(19)
               value "Return Amount Total".

       01 ws-output4.
           05 filler                           pic x(7).
           05 ws-return-total                  pic zzz.
           05 filler                           pic x(17).
           05 ws-return-total-amount           pic $zzz,zz9.99.

       01 ws-heading5.
           05 filler                           pic x(14)
               value "GRAND TOTAL = ".
           05 ws-grand-total-output            pic $zzz,zz9.99.

      *Transaction types: Sales, Layaways, Returns
       01 ws-transaction-codes.
           05 ws-transaction-s                 pic x
               value "S".
           05 ws-transaction-l                 pic x
               value "L".
           05 ws-transaction-r                 pic x
               value "R".

      *Program Counters
       01 ws-program-counters.
           05 ws-total-sl-counter              pic 999.
           05 ws-sales-counter                 pic 99.
           05 ws-layaway-counter               pic 99.
           05 ws-returns-counter               pic 99.
           05 ws-returns-count-1               pic 99.
           05 ws-returns-count-2               pic 99.
           05 ws-returns-count-3               pic 99.
           05 ws-returns-count-4               pic 99.
           05 ws-returns-count-5               pic 99.
           05 ws-returns-count-6               pic 99.

      *Program Total Amounts
       01 ws-total-amounts.
           05 ws-total-sl-amount               pic 9(6)v99.
           05 ws-total-sales-amount            pic 9(6)v99.
           05 ws-total-layaway-amount          pic 9(6)v99.
           05 ws-total-returns-amount          pic 9(6)v99.
           05 ws-grand-total-amount            pic 9(6)v99.

      *Store total amounts per store
       01 ws-store-totals.
           05 ws-store-total-1                 pic 9(5)v99.
           05 ws-store-total-2                 pic 9(5)v99.
           05 ws-store-total-3                 pic 9(5)v99.
           05 ws-store-total-4                 pic 9(5)v99.
           05 ws-store-total-5                 pic 9(5)v99.
           05 ws-store-total-6                 pic 9(5)v99.

      *Return totals per store
       01 ws-store-return-totals.
           05 ws-store-return-1                pic 9(5)v99.
           05 ws-store-return-2                pic 9(5)v99.
           05 ws-store-return-3                pic 9(5)v99.
           05 ws-store-return-4                pic 9(5)v99.
           05 ws-store-return-5                pic 9(5)v99.
           05 ws-store-return-6                pic 9(5)v99.

      *Payment types
       01 ws-payment-types.
           05 ws-payment-CA                    pic xx
               value "CA".
           05 ws-payment-CR                    pic xx
               value "CR".
           05 ws-payment-DB                    pic xx
               value "DB".

      *Payment Type Counters
       01 ws-type-counter.
           05 ws-cash-counter                  pic 999.
           05 ws-credit-counter                pic 999.
           05 ws-debit-counter                 pic 999.

      *Payment Percentages
       01 ws-type-percentages.
           05 ws-cash-percent                  pic 999.
           05 ws-credit-percent                pic 999.
           05 ws-debit-percent                 pic 999.

      *Total payment type counter to determine total percentages
      *per type
       77 ws-payment-type-counter              pic 999.

      *EOF Flag 
       77 ws-eof-flag                          pic x
               value "n".

       procedure division.
       000-Main.

      *Open input and output files
           open input in-file,
             output sales-layaway-file, return-file, report-file.

      *Read the input file, and if finished set to Y
           read in-file
               at end
                   move "y" to ws-eof-flag.

           write report-line                   from ws-heading
               after advancing 1 lines.

           move zeros                          to ws-program-counters,
             ws-total-amounts, ws-type-counter, ws-payment-type-counter
             , ws-type-percentages,ws-store-totals, 
             ws-store-return-totals.

           accept ws-sys-date                  from date.
           accept ws-sys-time                  from time.
           

           perform 100-mainLogic until ws-eof-flag = "y".

           perform 400-summaryReport.

      *Close the output and input files
           close sales-layaway-file, return-file, report-file,
             in-file.

           stop run.

      *This will initiate the process of sorting through inputs
       100-mainLogic.

           
      *    Determine if the input is a S, L, or R
           if (il-transaction-code = ws-transaction-s or
             ws-transaction-l) then

               perform 200-processSalesandLayaways

      *        Determine the amount of transaction per type
               if(il-payment-type = ws-payment-CA) then
                   add 1                       to ws-cash-counter
               else if (il-payment-type = ws-payment-CR) then
                   add 1                       to ws-credit-counter
               else if (il-payment-type = ws-payment-DB) then
                   add 1                       to ws-debit-counter
               end-if
               
      *    If the current input is a return
           else if (il-transaction-code = ws-transaction-r) then

               perform 300-processReturns

               
      *        Determine the total transaction amounts per store
               if (il-store-number = 01) then
                   add 1                       to ws-returns-count-1
                   add il-transaction-amount   to ws-store-return-1
               else if (il-store-number = 02) then
                   add 1                       to ws-returns-count-2
                   add il-transaction-amount   to ws-store-return-2
               else if (il-store-number = 03) then
                   add 1                       to ws-returns-count-3
                   add il-transaction-amount   to ws-store-return-3
               else if (il-store-number = 04) then
                   add 1                       to ws-returns-count-4
                   add il-transaction-amount   to ws-store-return-4
               else if (il-store-number = 05) then
                   add 1                       to ws-returns-count-5
                   add il-transaction-amount   to ws-store-return-5
               else if (il-store-number = 12) then
                   add 1                       to ws-returns-count-6
                   add il-transaction-amount   to ws-store-return-6
               end-if
           end-if.

           read in-file
               at end
                   move "y" to ws-eof-flag.

      *Process the sales and layaway data.
       200-processSalesandLayaways.

      *        Write to file
               write sales-layaway-line        from input-line.

      *        Increment total sales and layaway counter and total
               add 1                           to ws-total-sl-counter.
               add il-transaction-amount       to ws-total-sl-amount.

               if (il-store-number = 01) then
                   add il-transaction-amount   to ws-store-total-1
               else if (il-store-number = 02) then
                   add il-transaction-amount   to ws-store-total-2
               else if (il-store-number = 03) then
                   add il-transaction-amount   to ws-store-total-3
               else if (il-store-number = 04) then
                   add il-transaction-amount   to ws-store-total-4
               else if (il-store-number = 05) then
                   add il-transaction-amount   to ws-store-total-5
               else if (il-store-number = 12) then
                   add il-transaction-amount   to ws-store-total-6
               end-if.
       
      *        Increment respective codes via if statements
               if (il-transaction-code = ws-transaction-s) then

      *            If sales, increment sales counter and totals
                   add 1                       to ws-sales-counter
                   add il-transaction-amount   to ws-total-sales-amount

               else if (il-transaction-code = ws-transaction-l) then

      *            If layaway, increment layaway counter and totals
                   add 1                       to ws-layaway-counter
                   add il-transaction-amount   to
                     ws-total-layaway-amount

               end-if.
      
      *Process the returns file data.
       300-processReturns.

      *    Write to the return line
           write return-line                   from input-line.

      *    If return, increment return counter and totals
           add 1                               to ws-returns-counter.
           add il-transaction-amount           to 
               ws-total-returns-amount.

       400-summaryReport.

      *    Calculate the final grand total = sales/layaway amount - 
      *    total returns
           compute ws-grand-total-amount rounded = ws-total-sl-amount
               - ws-total-returns-amount.

      *    Calculate percentages for number of transactions
           compute ws-payment-type-counter = ws-cash-counter +
             ws-credit-counter + ws-debit-counter.

           compute ws-cash-percent rounded  = (ws-cash-counter / 
             ws-payment-type-counter) * 100.

           compute ws-credit-percent rounded = (ws-credit-counter /
             ws-payment-type-counter) * 100.

           compute ws-debit-percent rounded = (ws-debit-counter /
             ws-payment-type-counter) * 100.

      *    Formatted output for S&L records
           move ws-total-sl-counter        to ws-sl-total.
           move ws-total-sl-amount         to ws-sl-total-amount.
           move ws-sales-counter           to ws-sales.
           move ws-total-sales-amount      to ws-sales-amount.
           move ws-layaway-counter         to ws-layaways.
           move ws-total-layaway-amount    to ws-layaways-amount.

      *    Formmatted output for store transactions amounts for S & L
           move ws-store-total-1           to ws-sl-store1.
           move ws-store-total-2           to ws-sl-store2.
           move ws-store-total-3           to ws-sl-store3.
           move ws-store-total-4           to ws-sl-store4.
           move ws-store-total-5           to ws-sl-store5.
           move ws-store-total-6           to ws-sl-store6.

      *    Formmatted output for store percentages per type
           move ws-cash-percent            to ws-cash-perc.
           move ws-credit-percent          to ws-credit-perc.
           move ws-debit-percent           to ws-debit-perc.

      *    Formmatted output for returns
           move ws-returns-counter         to ws-return-total.
           move ws-total-returns-amount    to ws-return-total-amount.

           move ws-grand-total-amount      to ws-grand-total-output.

      *Write headers to the report line
           write report-line               from ws-heading1
               after advancing 2 lines.

           write report-line               from ws-output1
               after advancing 1 lines.

           write report-line               from ws-heading2
               after advancing 2 lines.

           write report-line               from ws-output2
               after advancing 1 lines.

           write report-line               from ws-heading3
               after advancing 2 lines.

           write report-line               from ws-output3
               after advancing 1 lines.

           write report-line               from ws-heading4
               after advancing 2 lines.

           write report-line               from ws-output4
               after advancing 1 lines.

      *    Formmatted output for store transactions amounts for returns 
           move ws-store-return-1          to ws-sl-store1.
           move ws-store-return-2          to ws-sl-store2.
           move ws-store-return-3          to ws-sl-store3.
           move ws-store-return-4          to ws-sl-store4.
           move ws-store-return-5          to ws-sl-store5.
           move ws-store-return-6          to ws-sl-store6.
           move "Returns: "                to ws-heading-total.
.
      *Outputting the file Returns lines
           write report-line               from ws-heading2
               after advancing 2 lines.

           write report-line               from ws-output2
               after advancing 1 lines.

      *Outputting the grand total to the report
           write report-line               from ws-heading5
               after advancing 3 lines.

       end program MAFD_Final.