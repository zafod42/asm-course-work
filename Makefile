
PWD=~/Documents/programming/asm/course_work/
TASM=~/Documents/DOS_ASM/tasm/


all: run

build: bin/COURSE.EXE

show:	
	cat BUILD.LOG LINK.LOG

bin/COURSE.EXE: src/course.asm
	dosbox 	-c "@echo off"\
		-c "cls"\
		-c "mount c $(TASM)"\
		-c "path=z:\\;c:\\"\
		-c "mount d $(PWD)/src/"\
		-c "mount e $(PWD)/bin/"\
		-c "e:"\
		-c "tasm d:\\course.asm > build.log"\
		-c "tlink course.obj > link.log"\
		-c "exit"

run: bin/COURSE.EXE
	dosbox 	-c "@echo off"\
		-c "mount d $(PWD)/bin"\
		-c "cls"\
		-c "d:\\course.exe"\
		-c "exit"

clean:
	rm bin/*.MAP bin/*.OBJ bin/*.EXE bin/*.LOG

