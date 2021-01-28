/**************************** REXX *********************************/
trace off                                                            
parse arg parms                                                      
                                                                     
parms = translate(parms,' ',',')                                     
parse var parms inputFile                                            
"ALLOC F(INP1) DA('"inputFile"') SHR REUSE"                          
"EXECIO * DISKR INP1 (STEM IN1. FINIS)"                              
"FREE F(INP1)"                                                       
 do i=1 to IN1.0                                                     
   if POS('ENDED - RC=',IN1.i)>0 then                                
     line=IN1.i                                                      
   else NOP                                                          
 end                                                                 
 line1=substr(line,index(line,'=')+1,length(line))                   
 if abs(strip(line1))<>0 then do                                     
   say 'Job failed on remote side'                                   
   exit 12                                                           
   end                                                               
 exit                              