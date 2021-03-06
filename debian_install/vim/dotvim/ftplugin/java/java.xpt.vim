XPTemplate priority=lang

let s:f = XPTcontainer()[0]
 
XPTvar $TRUE          true
XPTvar $FALSE         false
XPTvar $NULL          null
XPTvar $UNDEFINED     null

XPTvar $VOID_LINE  /* void */;
XPTvar $CURSOR_PH      /* cursor */

XPTvar $IF_BRACKET_STL     \ 
XPTvar $FOR_BRACKET_STL    \ 
XPTvar $WHILE_BRACKET_STL  \ 
XPTvar $STRUCT_BRACKET_STL \ 
XPTvar $FUNC_BRACKET_STL   \ 

XPTvar $CL    /*
XPTvar $CM    *
XPTvar $CR    */


XPTinclude 
      \ _common/common
      \ _comment/doubleSign
      \ _condition/c.like
      \ _loops/java.for.like
      \ _loops/c.while.like


" ========================= Function and Variables =============================

" ================================= Snippets ===================================
XPTemplateDef




XPT foreach hint=for\ \(\ ..\ :\ ..\ \)
for ( `type^ `var^ : `inWhat^ )`$FOR_BRACKET_STL^{
    `cursor^
}


XPT private hint=private\ ..\ ..
private `type^ `varName^;

XPT public hint=private\ ..\ ..
public `type^ `varName^;

XPT protected hint=private\ ..\ ..
protected `type^ `varName^;

XPT class hint=class\ ..\ ctor
public class `className^ {
    public `className^(` `ctorParam` ^)`$FUNC_BRACKET_STL^{
        `cursor^
    }
}


XPT main hint=main\ (\ String\ )
public static void main( String[] args )`$FUNC_BRACKET_STL^{
    `cursor^
}


XPT enum hint=public\ enum\ {\ ..\ }
`public^ enum `enumName^
{
    `elem^` `...^,
    `subElem^` `...^
};
`cursor^

XPT prop hint=var\ getVar\ ()\ setVar\ ()
`type^ `varName^;

`get...^
XSETm get...|post
public `R("type")^ get`S(R("varName"),'.','\u&',"")^()
    { return `R("varName")^; }

XSETm END
`set...^
XSETm set...|post
public `R("type")^ set`S(R("varName"),'.','\u&',"")^( `R('type')^ val )
    { `R("varName")^ = val; return `R( 'varName' )^; }

XSETm END


XPT try hint=try\ ..\ catch\ (..)\ ..\ finally
XSET handler=$CL handling $CR
try
{
    `what^
}` `catch...^
XSETm catch...|post

catch (`Exception^ `e^)
{
    `handler^
}` `catch...^
XSETm END
`finally...{{^finally
{
    `cursor^
}`}}^



" ================================= Wrapper ===================================


XPT try_ hint=try\ {\ SEL\ }\ catch...
XSET handler=$CL handling $CR
try
{
    `wrapped^
}` `catch...^
XSETm catch...|post

catch (`Exception^ `e^)
{
    `handler^
}` `catch...^
XSETm END
`finally...{{^finally
{
    `cursor^
}`}}^
