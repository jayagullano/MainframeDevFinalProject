       identification division.
       program-id. Edits.
       author. Deanna Slotegraaf.
       date-written. 2020-03-29.
      *Editted by Rolando 04/14/2020
      * Program Description: This is the program 1 for MAFD-4202. 
      *                 This program edits the input from the project3.
      *                 dat file to ensure it is valid.        

       environment division.
       configuration section.
       input-output section.
       select input-file
               assign to "../../../data/project3.dat"
               organization is line sequential.

            select invalid-records
               assign to "../../../data/Invalid.dat"
               organization is line sequential.

            select valid-records
               assign to "../../../data/Valid.dat"
               organization is line sequential.

           select error-records
               assign to "../../../data/Error.out"
               organization is line sequential.

       data division.
       file section.
       fd input-file
           data record is input-line
           record contains 36 characters.

      * Variables to get the data from the input line, used 88 variables
      * to allow for multiple data checks. 
       01 input-line.
           05 il-trans-code                    pic x.
               88 valid-trans-codes
                       value 'S', 'R', 'L'.
           05 il-trans-amount                  pic 9(5)v99.
           05 il-payment-type                  pic xx.
               88 valid-payment-types
                       value 'CA', 'CR', 'DB'.
           05 il-store-number                  pic xx.
               88 valid-store-nums
                       value '01', '02', '03', '04', '05', '12'.
           05 il-invoice-number                pic x(9).
           05 valid-invoice-number-r1 redefines il-invoice-number.
               10 valid-invoice-number-XX      pic x(2).
               10 valid-invoice-number-dash    pic x(1).
               88 valid-invoice-number-dash1
                       value '-'.
               10 valid-invoice-number-000000  pic 9(6).
           05 il-invoice-number-r4 redefines il-invoice-number.
               10 valid-invoice-number-letter  pic x(1).
               88 valid-invoice-number-1-letter
                        value 'A', 'B', 'C', 'D', 'E'.
               10 valid-invoice-number-letter  pic x(1).
               88 valid-invoice-number-2-letter
                       value 'A', 'B', 'C', 'D', 'E'.
               10 filler pic x(7).
           05 valid-invoice-number-r3 redefines il-invoice-number.
               10 valid-invoice-number-letter1 pic x(2).
               88 valid-invoice-number-duplicate
                        value 'AA', 'BB', 'CC', 'DD', 'EE'.
               10 filler pic x(1).
               10 il-invoice-number-num        pic 9(6).
               88 valid-invoice-number-invalid-range
                          value 0 thru 99999, 900001 thru 999999.
           05 il-sku-code                      pic x(15).
               88 valid-sku-code-blank
                       value spaces.
               88 valid-sku-code
                       value 'A' thru 'Z', '1' thru '9'.

       fd invalid-records
           data record is invalid-line
           record contains 36 characters.

       01 invalid-line                       pic x(36).

       fd valid-records
           data record is valid-line
           record contains 36 characters.

       01 valid-line                         pic x(36).

       fd error-records
           data record is error-line
           record contains 36 characters.

       01 error-line                         pic x(351).

       working-storage section.
       01 ws-eof-flag                        pic x value 'N'.

       01 ws-errors                          pic 99 value 0.

      * ---------------- 
      * ----Headings----
      * ----------------
       01 ws-heading-line1.
           05 filler                         pic x(8) value spaces.
           05 filler                         pic x(22)
             value "Group 7, Final Project".
           05 filler                         pic x(15)
                value spaces.
           05 ws-sys-date                    pic 9(6).
           05 filler                         pic x(15)
                value spaces.
           05 ws-sys-time                    pic 9(8).

       01 ws-heading-line2.
           05 filler                         pic x(40) value spaces.
           05 filler                         pic x(13)
           value " ERROR REPORT".
           05 filler                         pic x(38) value spaces.

       01 ws-heading-line3.
           05 filler                         pic x(11) value 
           "TRANSACTION".
           05 filler                         pic x(5) value spaces.
           05 filler                         pic x(11) value 
           "TRANSACTION".
           05 filler                         pic x(5) value spaces.
           05 filler                         pic x(7) value "PAYMENT".
           05 filler                         pic x(5) value spaces.
           05 filler                         pic x(5) value "STORE".
           05 filler                         pic x(5) value spaces.
           05 filler                         pic x(7) value "INVOICE".
           05 filler                         pic x(11) value spaces.
           05 filler                         pic x(3) value "SKU".
           05 filler                         pic x(30) value spaces.
           05 filler                         pic x(5) value "ERROR".

       01 ws-heading-line4.
           05 filler                         pic x(3) value spaces.
           05 filler                         pic x(4) value "CODE".
           05 filler                         pic x(11) value spaces.
           05 filler                         pic x(6) value "AMOUNT".
           05 filler                         pic x(10) value spaces.
           05 filler                         pic x(4) value "TYPE".
           05 filler                         pic x(6) value spaces.
           05 filler                         pic x(6) value "NUMBER".
           05 filler                         pic x(5) value spaces.
           05 filler                         pic x(6) value "NUMBER".
           05 filler                         pic x(11) value spaces.
           05 filler                         pic x(4) value "CODE".
           05 filler                         pic x(28) value spaces.
           05 filler                         pic x(7) value "MESSAGE".

       01 ws-detail-line.
           05 filler                         pic x(5) value spaces.
           05 ws-trans-code                  pic X.
           05 filler                         pic x(12) value spaces.
           05 ws-trans-amount                pic 9(5)V99.
           05 filler                         pic x(10) value spaces.
           05 ws-payment-type                pic XX.
           05 filler                         pic x(9) value spaces.
           05 ws-store-number                pic 99.
           05 filler                         pic x(6) value spaces.
           05 ws-invoice-number              pic x(9).
           05 filler                         pic x(5) value spaces.
           05 ws-sku-code                    pic x(15).
           05 filler                         pic x(5) value spaces.
           05 ws-error-message               pic x(300).

       01 ws-error-report1. 
           05 filler                         pic x(19)
              value "NUMBER OF RECORDS:".
           05 ws-rec-number                  pic zz9.

       01 ws-error-report2. 
           05 filler                         pic x(15)
              value "VALID RECORDS:".
           05 ws-valid-records               pic zz9.

       01 ws-error-report3.
           05 filler                         pic x(17)
               value "INVALID RECORDS:".
           05 ws-invalid-records             pic zz9.

       01 ws-counters.
           05 ws-record-count                pic 999 value 0.
           05 ws-valid-record-count          pic 999 value 0.
           05 ws-errors-count                pic 999 value 0.

       01 ws-error-text-constants.
           05 ws-trans-code-error            pic x(47) value
                        
               "Transaction Code must be 'S', 'R' or 'L'.      ".
           05 ws-trans-amount-error          pic x(47) value
                        
               "Transaction Amount must be numeric.            ".
           05 ws-payment-error               pic x(47) value
                        
               "Payment Type must be 'CA', 'CR', or 'DB'.      ".
           05 ws-store-num-error             pic x(47) value
                        
               "Store Number must be 01, 02, 03, 04, 05, or 12.".
           05 ws-invoice-num-error1          pic x(47) value
                        
               "Invoice Number must be in format XX-000000.    ".
           05 ws-invoice-num-error2          pic x(47) value
                        
               "Invoice Number XX can only be A, B, C, D, or E.".
           05 ws-invoice-num-error3          pic x(47) value
                        
               "Invoice Number XX cannot have two same letters.".
           05 ws-invoice-num-error4          pic x(47) value
                        
               "Invoice Number must be >100000 and <900000.    ".
           05 ws-invoice-num-error5          pic x(47) value
                        
               "All records should have a dash in position 3.  ".
           05 ws-sku-code-error1             pic x(47) value
                        
               "SKU Code cannot be empty.                      ".
           05 ws-sku-code-error2             pic x(47) value
                        
               "SKU Code should be alphanumeric.               ".

       77 ws-isError                         pic 9.
       procedure division.
       000-Main. 
           open input input-file,
             output invalid-records,
             valid-records,
             error-records.

      * --Outputs the data and time--
           accept ws-sys-date                from date.
           accept ws-sys-time                from time.

           read input-file
               at end
                   move 'Y' to ws-eof-flag.

           perform 100-process-headings.
           perform 200-process-validations
             until ws-eof-flag = 'Y'.
           write error-line                  from ws-error-report1 after
           advancing 1 line.
           write error-line                  from ws-error-report2.
           write error-line                  from ws-error-report3.

           close input-file,
             invalid-records,
             valid-records,
             error-records.

           stop run.
       100-process-headings.
           write error-line                  from ws-heading-line1.
           write error-line                  from ws-heading-line2.
           write error-line                  from ws-heading-line3.
           write error-line                  from ws-heading-line4.

       200-process-validations.
           add 1                             to ws-record-count.
           move ws-record-count              to ws-rec-number.

           add 0 to ws-isError.

      *If inputs are not valid, output to invalid data
           if not valid-trans-codes then
             move ws-trans-code-error        to ws-error-message
             perform 300-output-invalid-data
           else 
 
             if il-trans-amount not numeric then
               move ws-trans-amount-error    to ws-error-message
               perform 300-output-invalid-data
             else

               if not valid-payment-types then
                 move ws-payment-error       to ws-error-message
                 perform 300-output-invalid-data
               else

                 if not valid-store-nums then
                   move ws-store-num-error   to ws-error-message
                   perform 300-output-invalid-data
                 else

                   if not valid-invoice-number-XX alphabetic then
                     move ws-invoice-num-error1 to ws-error-message
                     perform 300-output-invalid-data
                   else

                     if not valid-invoice-number-dash1 then
                       move ws-invoice-num-error5 to ws-error-message
                       perform 300-output-invalid-data
                     else
                                   
                       if not valid-invoice-number-000000 numeric then
                         move ws-invoice-num-error1 to ws-error-message
                         perform 300-output-invalid-data
                       else
                                       
                         if not valid-invoice-number-1-letter then
                           move ws-invoice-num-error2 to 
                           ws-error-message
                           perform 300-output-invalid-data
                         else

                           if not valid-invoice-number-2-letter then
                             move ws-invoice-num-error2 to 
                             ws-error-message                           
                             perform 300-output-invalid-data
                           else
                                           
                             if valid-invoice-number-duplicate then
                               move ws-invoice-num-error3 to
                               ws-error-message
                               perform 300-output-invalid-data
                             else

                               if valid-invoice-number-invalid-range 
                               then
                                 move ws-invoice-num-error4 to
                                 ws-error-message
                                 perform 300-output-invalid-data
                               else

                                 if valid-sku-code-blank then
                                   move ws-sku-code-error1 to
                                   ws-error-message
                                   perform 300-output-invalid-data
                                 else

                                   if not valid-sku-code then
                                     move ws-sku-code-error2 to
                                     ws-error-message
                                     perform 300-output-invalid-data
                                   else

      *                                If valid, output to valid data
                                       perform 400-output-valid-data

                                                           end-if
                                                       end-if
                                                   end-if
                                               end-if
                                           end-if
                                       end-if
                                   end-if
                               end-if
                           end-if
                       end-if
                   end-if
               end-if
            end-if.

           read input-file
               at end
                   move 'Y'                to ws-eof-flag.

       300-output-invalid-data.
           write invalid-line              from input-line.

           move il-trans-code              to ws-trans-code.
           move il-trans-amount            to ws-trans-amount.
           move il-payment-type            to ws-payment-type.
           move il-store-number            to ws-store-number.
           move il-invoice-number          to ws-invoice-number.
           move il-sku-code                to ws-sku-code.

           write error-line                from ws-detail-line.

           add 1                           to ws-errors-count
           move ws-errors-count            to ws-invalid-records.

       400-output-valid-data.
           move il-trans-code              to ws-trans-code.
           move il-trans-amount            to ws-trans-amount.
           move il-payment-type            to ws-payment-type.
           move il-store-number            to ws-store-number.
           move il-invoice-number          to ws-invoice-number.
           move il-sku-code                to ws-sku-code.

           write valid-line                from input-line.

           add 1                           to ws-valid-record-count.

           move ws-valid-record-count      to ws-valid-records.
       end program Edits.