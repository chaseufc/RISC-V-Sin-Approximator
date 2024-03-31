.include "common.s"

.data
constant1: .double 0.992787728983164233059810507773856991
constant2: .double 0.146210290215383029232877806264248677


.text
setup:

	la t0, pi
	fld ft0, 0(t0) # ft0 = pi

	fdiv.d ft3, fa0, ft0 # ft3 = x/pi
	fcvt.w.d t1, ft3  # t1 = rounded(x/pi)= r
	li t2, 2
	rem t3, t1, t2 # t3 = r % 2
	beqz t3, ZeroCase 
	addi t4, zero, -1 # r % 2 was not zero, so t4 = i =-1
setupContinue:
	fcvt.d.w ft4, t4 # convert i to a float (to do math with)
	fcvt.d.w ft5, t1 # convert r to a float (to do math with)
	fmul.d ft5, ft5, ft0 # ft5 = r*pi
	fsub.d ft6, fa0, ft5 # ft6 = x- r*pi
	fmul.d fa0, ft4, ft6 # return i * (x - r*pi)
	ret 
	
	
ZeroCase: 
	li t4, 1 # r % 2 was zero, so t4 = i = 1
	j setupContinue
	


sin:
	addi sp,sp -4
	sw ra, 4(sp)
	jal setup
	lw ra, 4(sp)
	addi sp,sp,4
	
	la t0, constant1
	la t1, constant2
	fld ft0, 0(t0) # const 1
	fld ft1, 0(t1) # const 2
	
	fmul.d ft2, fa0, fa0 # ft2 =y ^2
	fmul.d ft2,ft2,ft1 # ft2 *= const2
	fsub.d ft2, ft0,ft2 # ft2 = const1 - ft2
	fmul.d fa0, fa0, ft2 # return ft2*y
	ret
	
