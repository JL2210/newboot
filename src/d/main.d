import lib.newboot;

extern(C):

shared(short)* vid_mem = cast(shared(short)*)VIDEO_MEM;

string welcome = "\t\tWelcome to the strange land of protected mode!\r\n";

int main()
{
	clear(B_BLACK | LIGHT_GRAY, &vid_mem);
	pm_write(welcome, welcome.length, B_BLACK | LIGHT_GRAY, &vid_mem);
	return 0;
}
