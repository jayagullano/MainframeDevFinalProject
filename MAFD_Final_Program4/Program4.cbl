       identification division.
       program-id. MAFD_Final_Program4.
       author. Rolando Agullano.
       date-written. 2020-03-27.
      *Purpose: This program takes input from the Return.dat file
      *created by Program 2, and creates a report.

       environment division.
       input-output section.
       file-control.

            select in-file
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

       fd report-file
           record contains 93 characters
           data record is report-line.

      *Grad-line will output 
       01 report-line.
           05 filler                           pic x(91).
           
       working-storage section.

      *Headers For Formatting Purposes:

       01 ws-heading1.
           05 filler                           pic x(14) value spaces.
           05 filler                           pic x(32)
            value "Group 7, Final Project Program 4".
           05 filler                           pic x(15)
            value spaces.
           05 ws-sys-date                      pic 9(6).
           05 filler                           pic x(15)
            value spaces.
           05 ws-sys-time                      pic 9(8).

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
           05 filler                           pic x(81).
           05 filler                           pic x(5)
               value "Page ".
           05 ws-page-number                   pic 99.

       01 ws-heading6.
           05 filler                           pic x(18)
               value "Total Taxes Owed: ".
           05 ws-total-taxes                   pic $zz,zz9.99.

      *Program Counters
       01 ws-program-counters.
           05 ws-returns-counter               pic 99.
           05 ws-returns-count-1               pic 99.
           05 ws-returns-count-2               pic 99.
           05 ws-returns-count-3               pic 99.
           05 ws-returns-count-4               pic 99.
           05 ws-returns-count-5               pic 99.
           05 ws-returns-count-6               pic 99.

      *Program Total Amounts
       01 ws-total-amounts.
           05 ws-total-returns-amount          pic 9(6)v99.
           05 ws-total-tax-amount              pic 9(6)v99.

      *Return totals per store
       01 ws-store-return-totals.
           05 ws-store-return-1                pic 9(5)v99.
           05 ws-store-return-2                pic 9(5)v99.
           05 ws-store-return-3                pic 9(5)v99.
           05 ws-store-return-4                pic 9(5)v99.
           05 ws-store-return-5                pic 9(5)v99.
           05 ws-store-return-6                pic 9(5)v99.
           05 ws-return-amount                 pic 9(5)v99.

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
                   move "y"                   to ws-eof-flag.

           move zeros                         to ws-program-counters,
             ws-total-amounts, ws-store-return-totals, ws-page-num,
             ws-page-counter.

           perform 300-formatPage.

           write report-line from ws-heading1
             after advancing 2 lines.

           accept ws-sys-date from date.
           accept ws-sys-time from time.
           
           
           write report-line                   from ws-heading3
               after advancing 1 lines.

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
           

      *    If return, increment return counter and totals
           add 1                               to ws-returns-counter.
           add il-transaction-amount           to
             ws-total-returns-amount.
               
      *    Determine the total transaction amounts per store
           if (il-store-number = 01) then
               add 1                           to ws-returns-count-1
               add il-transaction-amount       to ws-store-return-1
           else if (il-store-number = 02) then
               add 1                           to ws-returns-count-2
               add il-transaction-amount       to ws-store-return-2
           else if (il-store-number = 03) then
               add 1                           to ws-returns-count-3
               add il-transaction-amount       to ws-store-return-3
           else if (il-store-number = 04) then
               add 1                           to ws-returns-count-4
               add il-transaction-amount       to ws-store-return-4
           else if (il-store-number = 05) then
               add 1                           to ws-returns-count-5
               add il-transaction-amount       to ws-store-return-5
           else if (il-store-number = 12) then
               add 1                           to ws-returns-count-6
               add il-transaction-amount       to ws-store-return-6
           end-if.

           read in-file
               at end
                   move "y" to ws-eof-flag.

      *Sets the input from the .dat into formatted output for report
       200-processRecord.

           move il-transaction-code        to ws-transaction-code.
           move il-transaction-amount      to ws-transaction-amount.
           move il-payment-type            to ws-payment-type.
           move il-store-number            to ws-store-number.
           move il-invoice-number          to ws-invoice-number.
           move il-sku-code                to ws-sku-code.
       
      *    Calculate tax per each record
           compute ws-return-amount rounded = il-transaction-amount *
             0.13.

      *    Sets the return amount for a record

           move ws-return-amount           to ws-taxes-owed.

      *    Adds the tax amount to the total taxes returned to us

           add ws-return-amount            to ws-total-tax-amount.

           write report-line               from ws-output3
               after advancing 1 lines.

       300-formatPage.

           add 1                           to ws-page-num.
           move ws-page-num                to ws-page-number.

           write report-line               from ws-heading5
               after advancing 3 lines.
           write report-line               from " ".

       400-summaryReport.

      *    Formmatted output for returns
           move ws-returns-counter         to ws-return-total.
           move ws-total-returns-amount    to ws-return-total-amount.

      *    Adds the total taxes to the header for output

           move ws-total-tax-amount        to ws-total-taxes.

      *Write headers to the report line

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

      *    Outputting the file Returns lines
           write report-line               from ws-heading2
               after advancing 2 lines.

           write report-line               from ws-output2
               after advancing 1 lines.

      *    Outputs the total taxes owed back to us
           write report-line               from ws-heading6
             after advancing 2 lines.

       end program MAFD_Final_Program4.