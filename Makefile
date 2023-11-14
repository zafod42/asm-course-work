
PWD=~/Documents/programming/asm/course_work
TASM=~/Documents/DOS_ASM/tasm


all: run

build: COURSE.EXE

show:	
	cat BUILD.LOG LINK.LOG

COURSE.EXE: course.asm
	dosbox 	-c "mount c $(TASM)"\
		-c "path=z:\\;c:\\"\
		-c "mount d $(PWD)"\
		-c "d:"\
		-c "tasm course.asm >build.log"\
		-c "tlink course.obj>link.log"\
		-c "exit"

run: COURSE.EXE
	dosbox 	-c "mount d $(PWD)"\
		-c "d:\\course.exe"

clean:
	rm *.MAP *.OBJ *.EXE *.LOG
