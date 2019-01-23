int
 _ClockActivo,
 _ClockRow,
 _ClockCol,
 _ClockAttr,
 _ClockOn;
long
 _TimeCounter;

void interrupt _ResClock(void);
void interrupt (*_OldHandler) (void);
