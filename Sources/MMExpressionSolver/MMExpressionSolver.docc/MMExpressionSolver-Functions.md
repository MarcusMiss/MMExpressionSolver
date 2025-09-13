# Functions

@Metadata {
    @PageColor(red)
    @PageImage(purpose: icon, source: "function") 
    @SupportedLanguage(swift)
}

`MMExpression` provided a lot of functions out of the box. But it is easy to add own functions.

## Overview

The overview of predefined functions are ordered by their domain.
If you choose the `createDefault()` of ``ExpressionConfiguration`` all operators and functions are registered.

### String functions

Overview of `String`-related functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionHASPOSTFIX>
- <doc:MMExpressionSolver/FunctionHASPREFIX>
- <doc:MMExpressionSolver/FunctionLEFT>
- <doc:MMExpressionSolver/FunctionLEN>
- <doc:MMExpressionSolver/FunctionLOWER>
- <doc:MMExpressionSolver/FunctionLTRIM>
- <doc:MMExpressionSolver/FunctionMID>
- <doc:MMExpressionSolver/FunctionREPLACEALL>
- <doc:MMExpressionSolver/FunctionREPLACEFIRST>
- <doc:MMExpressionSolver/FunctionRIGHT>
- <doc:MMExpressionSolver/FunctionRTRIM>
- <doc:MMExpressionSolver/FunctionTRIM>
- <doc:MMExpressionSolver/FunctionTRIMPOSTFIX>
- <doc:MMExpressionSolver/FunctionTRIMPREFIX>
- <doc:MMExpressionSolver/FunctionUPPER>
- <doc:MMExpressionSolver/FunctionUUID>

### Date functions

Overview of `Date`-related functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionADDDAY>
- <doc:MMExpressionSolver/FunctionADDHOUR>
- <doc:MMExpressionSolver/FunctionADDMINUTE>
- <doc:MMExpressionSolver/FunctionADDMONTH>
- <doc:MMExpressionSolver/FunctionADDSECOND>
- <doc:MMExpressionSolver/FunctionADDYEAR>
- <doc:MMExpressionSolver/FunctionDATE>
- <doc:MMExpressionSolver/FunctionGETDAY>
- <doc:MMExpressionSolver/FunctionGETHOUR>
- <doc:MMExpressionSolver/FunctionGETMINUTE>
- <doc:MMExpressionSolver/FunctionGETMONTH>
- <doc:MMExpressionSolver/FunctionGETSECOND>
- <doc:MMExpressionSolver/FunctionGETYEAR>
- <doc:MMExpressionSolver/FunctionNOW>

### Mathematical functions

Overview of mathematical functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionABS>
- <doc:MMExpressionSolver/FunctionAVG>
- <doc:MMExpressionSolver/FunctionCBRT>
- <doc:MMExpressionSolver/FunctionCEIL>
- <doc:MMExpressionSolver/FunctionFLOOR>
- <doc:MMExpressionSolver/FunctionMAX>
- <doc:MMExpressionSolver/FunctionMIN>
- <doc:MMExpressionSolver/FunctionPOWER>
- <doc:MMExpressionSolver/FunctionROUND>
- <doc:MMExpressionSolver/FunctionSIGN>
- <doc:MMExpressionSolver/FunctionSQRT>
- <doc:MMExpressionSolver/FunctionSUM>

### Trigonometry functions

Overview of trigonometry functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionACOS>
- <doc:MMExpressionSolver/FunctionACOSEC>
- <doc:MMExpressionSolver/FunctionACOSECH>
- <doc:MMExpressionSolver/FunctionACOSH>
- <doc:MMExpressionSolver/FunctionACOTAN>
- <doc:MMExpressionSolver/FunctionACOTANH>
- <doc:MMExpressionSolver/FunctionASEC>
- <doc:MMExpressionSolver/FunctionASECH>
- <doc:MMExpressionSolver/FunctionASIN>
- <doc:MMExpressionSolver/FunctionASINH>
- <doc:MMExpressionSolver/FunctionATAN>
- <doc:MMExpressionSolver/FunctionATAN2>
- <doc:MMExpressionSolver/FunctionATANH>
- <doc:MMExpressionSolver/FunctionCOS>
- <doc:MMExpressionSolver/FunctionCOSEC>
- <doc:MMExpressionSolver/FunctionCOSECH>
- <doc:MMExpressionSolver/FunctionCOSH>
- <doc:MMExpressionSolver/FunctionCOTAN>
- <doc:MMExpressionSolver/FunctionDEG>
- <doc:MMExpressionSolver/FunctionHYPOT>
- <doc:MMExpressionSolver/FunctionRAD>
- <doc:MMExpressionSolver/FunctionSEC>
- <doc:MMExpressionSolver/FunctionSECH>
- <doc:MMExpressionSolver/FunctionSIN>
- <doc:MMExpressionSolver/FunctionSINH>
- <doc:MMExpressionSolver/FunctionTAN>
- <doc:MMExpressionSolver/FunctionTANH>

### Logarithmic functions

Overview of logarithmic functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionLOG>
- <doc:MMExpressionSolver/FunctionLOG1P>
- <doc:MMExpressionSolver/FunctionLOG10>
- <doc:MMExpressionSolver/FunctionLOGN>

### Miscellaneous functions

Overview of miscellaneous functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionARRAYLEN>
- <doc:MMExpressionSolver/FunctionIF>
- <doc:MMExpressionSolver/FunctionISNOTNULL>
- <doc:MMExpressionSolver/FunctionISNULL>

### Conversion functions

Overview of converter functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionCDBL>
- <doc:MMExpressionSolver/FunctionCDEC>
- <doc:MMExpressionSolver/FunctionCFLT>
- <doc:MMExpressionSolver/FunctionCINT>
- <doc:MMExpressionSolver/FunctionCSTR>

### Measurement functions

Overview of measurement-related functions in alphabetical order.

- <doc:MMExpressionSolver/FunctionUNITACCELERATION>
- <doc:MMExpressionSolver/FunctionUNITANGLE>
- <doc:MMExpressionSolver/FunctionUNITAREA>
- <doc:MMExpressionSolver/FunctionUNITCONCENTRATIONMASS>
- <doc:MMExpressionSolver/FunctionUNITCONVERT>
- <doc:MMExpressionSolver/FunctionUNITDISPERSION>
- <doc:MMExpressionSolver/FunctionUNITDURATION>
- <doc:MMExpressionSolver/FunctionUNITELECTRICCHARGE>
- <doc:MMExpressionSolver/FunctionUNITELECTRICCURRENT>
- <doc:MMExpressionSolver/FunctionUNITELECTRICPOTENTIALDIFFERENCE>
- <doc:MMExpressionSolver/FunctionUNITELECTRICRESISTENCE>
- <doc:MMExpressionSolver/FunctionUNITENERGY>
- <doc:MMExpressionSolver/FunctionUNITFREQUENCY>
- <doc:MMExpressionSolver/FunctionUNITFUELEFFICIENCY>
- <doc:MMExpressionSolver/FunctionUNITILLUMINANCE>
- <doc:MMExpressionSolver/FunctionUNITINFORMATIONSTORAGE>
- <doc:MMExpressionSolver/FunctionUNITLENGTH>
- <doc:MMExpressionSolver/FunctionUNITMASS>
- <doc:MMExpressionSolver/FunctionUNITPOWER>
- <doc:MMExpressionSolver/FunctionUNITPRESSURE>
- <doc:MMExpressionSolver/FunctionUNITSPEED>
- <doc:MMExpressionSolver/FunctionUNITTEMPERATURE>
- <doc:MMExpressionSolver/FunctionUNITVOLUME>
