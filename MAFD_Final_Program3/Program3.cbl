       identification division.
       program-id. MAFD_Final_Program3.
       author. Elinam Amegah.
       date-written. 2020-03-27.
      *Purpose: This program takes input from the Sales_Layaway.dat file
      *created by Program 2, and creates a report.

       environment division.
       input-output section.
       file-control.

            select in-file
                assign to '../../../data/Sales_Layaway.dat'
                organization is line sequential.

           select report-file
                assign to '../../../data/SalesReport.out'
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

       fd report-file
           record contains 93 characters
           data record is report-line.

      *Grad-line will output
       01 report-line.
           05 filler                           pic x(93).

       working-storage section.

      *Headers For Formatting Purposes:

       01 ws-heading1.
           05 filler                           pic x(14) value spaces.
           05 filler                           pic x(39)
            value "Group 7, Final Project Program 3 Report".
           05 filler                           pic x(15)
            value spaces.
           05 ws-sys-date                      pic 9(6).
           05 filler                           pic x(15)
            value spaces.
           05 ws-sys-time                      pic 9(8).

       01 ws-heading2.
           05 filler                           pic x(14)
               value "Sale Totals:  ".
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
           05 filler                           pic x(10)
               value "Trans Code".
           05 filler                           pic x(3).
           05 filler                           pic x(12)
               value "Trans Amount".
           05 filler                           pic x(3).
           05 filler                           pic x(12)
               value "Payment Type".
           05 filler                           pic x(3).
           05 filler                           pic x(7)
               value "Store #".
           05 filler                           pic x(3).
           05 filler                           pic x(9)
               value "Invoice #".
           05 filler                           pic x(10).
           05 filler                           pic x(8)
               value "SKU Code".
           05 filler                           pic x(3).
           05 filler                           pic x(10)
               value "Tax $".

       01 ws-output3.
           05 filler                           pic x(9).
           05 ws-transaction-code              pic x.
           05 filler                           pic x(5).
           05 ws-transaction-amount            pic $zz,zz9.99.
           05 filler                           pic x(13).
           05 ws-payment-type                  pic xx.
           05 filler                           pic x(8).
           05 ws-store-number                  pic zz.
           05 filler                           pic x(3).
           05 ws-invoice-number                pic x(9).
           05 filler                           pic x(3).
           05 ws-sku-code                      pic x(15).
           05 filler                           pic x(2).
           05 ws-taxes-owed                    pic zz9.99.

       01 ws-heading4.
           05 filler                           pic x(31)
               value "# Of Total Sales and Layaways: ".
           05 filler                           pic x(8).
           05 filler                           pic x(18)
               value "Sales Amount Total".

       01 ws-output4.
           05 filler                           pic x(19).
           05 ws-saleandlay-total                  pic zzz.
           05 filler                           pic x(17).
           05 ws-saleandlay-total-amount           pic $zzz,zz9.99.

       01 ws-heading5.
           05 filler                           pic x(81).
           05 filler                           pic x(5)
               value "Page ".
           05 ws-page-number                   pic 99.

       01 ws-heading6.
           05 filler                           pic x(18)
               value "Total Taxes Owed: ".
           05 ws-total-taxes                   pic $zz,zz9.99.

      *Header and output for total sales or layaways
       01 ws-heading-total_sl.
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

       01 ws-output-total-sl.
           05 filler                           pic x(4).
           05 ws-sales                         pic zzz.
           05 filler                           pic x(6).
           05 ws-sales-amount                  pic $zzz,zz9.99.
           05 filler                           pic x(8).
           05 ws-layaways                      pic zzz.
           05 filler                           pic x(8).
           05 ws-layaways-amount               pic $zzz,zz9.99.

      *Header and Output for Payment Types
       01 ws-heading-payment-type.
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

       01 ws-output-payment-type.
           05 filler                           pic x(17).
           05 filler                           pic x value "%".
           05 ws-cash-perc                     pic z99.
           05 filler                           pic x(5).
           05 filler                           pic x value "%".
           05 ws-credit-perc                   pic z99.
           05 filler                           pic x(7).
           05 filler                           pic x value "%".
           05 ws-debit-perc                    pic z99.

      * Headers for the highest and lowest store amounts
       01 ws-heading-highandlow.
           05 filler                           pic x(21)
               value "Highest Store Totals:".
           05 filler                           pic x(3).
           05 filler                           pic x(20)
               value "Lowest Store Totals:".

       01 ws-output-highandlow.
           05 filler                           pic x(12).
           05 filler                           pic x(7)
               value "Store: ".
           05 ws-highest-store                 pic 99.
           05 filler                           pic x(14).
           05 filler                           pic x(7)
               value "Store: ".
           05 ws-lowest-store                 pic 99.

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

      *Program Counters
       01 ws-program-counters.
           05 ws-sl-counter                    pic 99.
           05 ws-sales-counter                 pic 99.
           05 ws-layaway-counter               pic 99.
           05 ws-sales-count-1                 pic 99.
           05 ws-sales-count-2                 pic 99.
           05 ws-sales-count-3                 pic 99.
           05 ws-sales-count-4                 pic 99.
           05 ws-sales-count-5                 pic 99.
           05 ws-sales-count-6                 pic 99.
           05 ws-payment-type-counter          pic 999.

      *Program Total Amounts
       01 ws-total-amounts.
           05 ws-total-sl-amount               pic 9(6)v99.
           05 ws-total-tax-amount              pic 9(6)v99.
           05 ws-total-sales-amount            pic 9(6)v99.
           05 ws-total-layaway-amount          pic 9(6)v99.

      *Transaction types: Sales, Layaways, Returns
       01 ws-transaction-codes.
           05 ws-transaction-s                 pic x
               value "S".
           05 ws-transaction-l                 pic x
               value "L".

      *Sales and Layaways totals per store
       01 ws-store-sl-totals.
           05 ws-store-sl-1                    pic 9(5)v99.
           05 ws-store-sl-2                    pic 9(5)v99.
           05 ws-store-sl-3                    pic 9(5)v99.
           05 ws-store-sl-4                    pic 9(5)v99.
           05 ws-store-sl-5                    pic 9(5)v99.
           05 ws-store-sl-6                    pic 9(5)v99.
           05 ws-sl-amount                     pic 9(5)v99.
           05 ws-store-highest                 pic 99.
           05 ws-store-lowest                  pic 99.

      *EOF Flag
       77 ws-eof-flag                          pic x
               value "n".

       77 ws-page-counter                      pic 99.
       77 ws-page-num                          pic 99.

       procedure division.
       000-Main.

      *Open input and output files
           open input in-file,
             output report-file.

      *Read the input file, and if finished set to Y
           read in-file
               at end
                   move "y"                    to ws-eof-flag.

           write report-line                   from ws-heading1
             after advancing 2 lines.

           move zeros                          to ws-program-counters,
             ws-total-amounts, ws-store-sl-totals, ws-page-num,
             ws-page-counter, ws-type-counter.

           perform 300-formatPage.

           accept ws-sys-date                  from date.
           accept ws-sys-time                  from time.

           perform 100-mainLogic until ws-eof-flag = "y".

           perform 400-summaryReport.

      *Close the output and input files
           close  report-file, in-file.

           stop run.

       100-mainLogic.

      *    Write each record to report
           perform 200-processRecord

      *    Increment page, and perform formatting
           if (ws-page-counter >= 20) then
               perform 300-formatPage
               move zeros                      to ws-page-counter
           else
               add 1                           to ws-page-counter
           end-if.

      *    If sales or layaway, increment counter and totals
           add 1                               to ws-sl-counter.
           add il-transaction-amount           to
             ws-total-sl-amount.

      *    Determine the amount of transaction per type
           if(il-payment-type = ws-payment-CA) then
               add 1                           to ws-cash-counter
           else if (il-payment-type = ws-payment-CR) then
               add 1                           to ws-credit-counter
           else if (il-payment-type = ws-payment-DB) then
               add 1                           to ws-debit-counter
           end-if.

      *    Determine the total transaction amounts per store
           if (il-store-number = 01) then
               add 1                           to ws-sales-count-1
               add il-transaction-amount       to ws-store-sl-1
           else if (il-store-number = 02) then
               add 1                           to ws-sales-count-2
               add il-transaction-amount       to ws-store-sl-2
           else if (il-store-number = 03) then
               add 1                           to ws-sales-count-3
               add il-transaction-amount       to ws-store-sl-3
           else if (il-store-number = 04) then
               add 1                           to ws-sales-count-4
               add il-transaction-amount       to ws-store-sl-4
           else if (il-store-number = 05) then
               add 1                           to ws-sales-count-5
               add il-transaction-amount       to ws-store-sl-5
           else if (il-store-number = 12) then
               add 1                           to ws-sales-count-6
               add il-transaction-amount       to ws-store-sl-6
           end-if.

           read in-file
               at end
                   move "y" to ws-eof-flag.

      *Sets the input from the .dat into formatted output for report
       200-processRecord.

           move il-transaction-code            to ws-transaction-code.
           move il-transaction-amount          to ws-transaction-amount.
           move il-payment-type                to ws-payment-type.
           move il-store-number                to ws-store-number.
           move il-invoice-number              to ws-invoice-number.
           move il-sku-code                    to ws-sku-code.

      *    Calculate tax per each record
           compute ws-sl-amount rounded = il-transaction-amount *
             0.13.


      *    Increment respective codes via if statements
           if (il-transaction-code = ws-transaction-s) then

      *    If sales, increment sales counter and totals
               add 1                           to ws-sales-counter
               add il-transaction-amount       to ws-total-sales-amount

           else if (il-transaction-code = ws-transaction-l) then

      *    If layaway, increment layaway counter and totals
               add 1                           to ws-layaway-counter
               add il-transaction-amount       to
               ws-total-layaway-amount

            end-if.

      *    Sets the sales and layaway amount for a record

           move ws-sl-amount               to ws-taxes-owed.

      *    Adds the tax amount to the total taxes returned to us

           add ws-sl-amount                to ws-total-tax-amount.

           write report-line               from ws-output3
               after advancing 1 lines.

       300-formatPage.

           add 1                           to ws-page-num.
           move ws-page-num                to ws-page-number.


           write report-line               from ws-heading5
               after advancing 3 lines.
           write report-line               from " ".
           write report-line                   from ws-heading3
               after advancing 1 lines.


       400-summaryReport.

      *    Calculate percentages for number of transactions
           compute ws-payment-type-counter = ws-cash-counter +
             ws-credit-counter + ws-debit-counter.

           compute ws-cash-percent rounded  = (ws-cash-counter /
             ws-payment-type-counter) * 100.

           compute ws-credit-percent rounded = (ws-credit-counter /
             ws-payment-type-counter) * 100.

           compute ws-debit-percent rounded = (ws-debit-counter /
             ws-payment-type-counter) * 100.

      *    Formmatted output for store percentages per type
           move ws-cash-percent            to ws-cash-perc.
           move ws-credit-percent          to ws-credit-perc.
           move ws-debit-percent           to ws-debit-perc.

      *    Formmatted output for sales and layaways
           move ws-sl-counter              to ws-saleandlay-total.
           move ws-total-sl-amount         to
             ws-saleandlay-total-amount.
           move ws-sales-counter           to ws-sales.
           move ws-total-sales-amount      to ws-sales-amount.
           move ws-layaway-counter         to ws-layaways.
           move ws-total-layaway-amount    to ws-layaways-amount.

      *    Adds the total taxes to the header for output

           move ws-total-tax-amount        to ws-total-taxes.

      *Write headers to the report line

           write report-line               from ws-heading4
               after advancing 2 lines.

           write report-line               from ws-output4
               after advancing 1 lines.

           write report-line               from ws-heading-total_sl
               after advancing 2 lines.

           write report-line               from ws-output-total-sl
               after advancing 1 lines.


      *Outputs the percentage per payment type
           write report-line               from ws-heading-payment-type
               after advancing 2 lines.

           write report-line               from ws-output-payment-type
               after advancing 1 lines.

      *    Formmatted output for store transactions amounts for sales
           move ws-store-sl-1              to ws-sl-store1.
           move ws-store-sl-2              to ws-sl-store2.
           move ws-store-sl-3              to ws-sl-store3.
           move ws-store-sl-4              to ws-sl-store4.
           move ws-store-sl-5              to ws-sl-store5.
           move ws-store-sl-6              to ws-sl-store6.

      *    Determine if the following store is greater than the previous
           if (ws-store-sl-1 > ws-store-sl-2 and
                               ws-store-sl-3 and
                               ws-store-sl-4 and
                               ws-store-sl-5 and
                               ws-store-sl-6) then
               move 1                      to ws-store-highest
           else if (ws-store-sl-2 > ws-store-sl-3 and
                                    ws-store-sl-4 and
                                    ws-store-sl-5 and
                                    ws-store-sl-6) then
               move 2                      to ws-store-highest
           else if (ws-store-sl-3 > ws-store-sl-4 and
                                    ws-store-sl-5 and
                                    ws-store-sl-6) then
               move 3                      to ws-store-highest
           else if (ws-store-sl-4 > ws-store-sl-5 and
                                    ws-store-sl-6) then
               move 4                      to ws-store-highest
           else if (ws-store-sl-5 > ws-store-sl-6) then
               move 5                      to ws-store-highest
           else
               move 12                     to ws-store-highest
           end-if.

      *    Determine if the following store is lower than the previous
           if (ws-store-sl-1 < ws-store-sl-2 and
                               ws-store-sl-3 and
                               ws-store-sl-4 and
                               ws-store-sl-5 and
                               ws-store-sl-6) then
               move 1                      to ws-store-lowest
           else if (ws-store-sl-2 < ws-store-sl-3 and
                                    ws-store-sl-4 and
                                    ws-store-sl-5 and
                                    ws-store-sl-6) then
               move 2                      to ws-store-lowest
           else if (ws-store-sl-3 < ws-store-sl-4 and
                                    ws-store-sl-5 and
                                    ws-store-sl-6) then
               move 3                      to ws-store-lowest
           else if (ws-store-sl-4 < ws-store-sl-5 and
                                    ws-store-sl-6) then
               move 4                      to ws-store-lowest
           else if (ws-store-sl-5 < ws-store-sl-6) then
               move 5                      to ws-store-lowest
           else
               move 12                     to ws-store-highest
           end-if.

      *    Set the highest store
           move ws-store-highest           to ws-highest-store.
           move ws-store-lowest            to ws-lowest-store.

      *    Outputting the file sales lines
           write report-line               from ws-heading2
               after advancing 2 lines.

           write report-line               from ws-output2
               after advancing 1 lines.

           write report-line               from ws-heading-highandlow
               after advancing 2 lines.

           write report-line               from ws-output-highandlow
               after advancing 1 lines.

      *    Outputs the total taxes owed back to us
           write report-line               from ws-heading6
             after advancing 2 lines.

       end program MAFD_Final_Program3.
