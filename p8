8.a. Write a C program to read n characters from a file and append them back
to the same file using dup2 function.
Here's a C program that reads n characters from a file and appends them back to the same file using
the dup2 function:
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#define MAX_SIZE 100
int main() {
 char filename[] = "file.txt";
 int fd, new_fd;
 char buffer[MAX_SIZE];
 ssize_t bytes_read;
 int n;
 printf("Enter the number of characters to read and append: ");
 scanf("%d", &n);
 // Open the file
 fd = open(filename, O_RDWR);
 if (fd == -1) {
 perror("Error opening file");
 exit(EXIT_FAILURE);
 }
 // Move file pointer to the end
 lseek(fd, 0, SEEK_END);
 // Duplicate file descriptor
 new_fd = dup(fd);
 if (new_fd == -1) {
 perror("Error duplicating file descriptor");
 close(fd);
 exit(EXIT_FAILURE);
 }
 // Move the file pointer back 'n' characters
 lseek(fd, -n, SEEK_END);
 // Read 'n' characters from the file
 bytes_read = read(fd, buffer, n);
 if (bytes_read == -1) {
 perror("Error reading file");
 close(fd);
 close(new_fd);
 exit(EXIT_FAILURE);
 }
 // Append the read characters back to the file
 if (write(new_fd, buffer, bytes_read) != bytes_read) {
 perror("Error writing to file");
 close(fd);
 close(new_fd);
 exit(EXIT_FAILURE);
 }
 // Close file descriptors
 close(fd);
 close(new_fd);
 printf("%d characters read and appended successfully.\n", (int)bytes_read);
 return 0;
}
Explanation:
1. We include necessary header files like <stdio.h>, <stdlib.h>, <unistd.h>, and <fcntl.h>
for file operations and standard I/O functions.
2. We define a macro MAX_SIZE for the maximum buffer size.
3. In the main() function:
o We prompt the user to enter the number of characters to read and append.
o Open the file in read-write mode (O_RDWR).
o Move the file pointer to the end of the file using lseek() to prepare for appending.
o Duplicate the file descriptor using dup() to have two descriptors pointing to the
same file.
o Move the file pointer back 'n' characters from the end using lseek().
o Read 'n' characters from the file using read().
o Append the read characters back to the file using write().
o Close the file descriptors.
Execution Steps:
1. Compile the program using a C compiler (e.g., gcc -o read_and_append
read_and_append.c).
2. Create a text file named file.txt with some content.
3. Run the compiled program (./read_and_append) .
4. Enter the number of characters to read and append.
5. The program reads the specified number of characters from the end of the file and appends
them back to the same file.
6. Verify the changes in file.txt.
8.b. Write a C program to list all files in a current directory using system
calls.
To list all files in the current directory using system calls in C, you can use the opendir, readdir,
and closedir functions. Here's a simple C program to achieve this:
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
int main() {
 DIR *dir;
 struct dirent *entry;
 // Open the current directory
 dir = opendir(".");
 if (dir == NULL) {
 perror("Error opening directory");
 exit(EXIT_FAILURE);
 }
 // Read and print all files in the directory
 while ((entry = readdir(dir)) != NULL) {
 if (entry->d_type == DT_REG) {
 printf("%s\n", entry->d_name);
 }
 }
 // Close the directory
 closedir(dir);
 return 0;
}
Explanation:
1. We include necessary header files like <stdio.h>, <stdlib.h>, and <dirent.h> for
directory-related operations.
2. In the main() function:
o We declare a DIR pointer (dir) to represent the directory stream and a struct dirent pointer
(entry) to represent a directory entry.
o Open the current directory (.) using opendir() and handle errors if the directory cannot be
opened.
o Loop through each entry in the directory using readdir(). Print the names of regular files
(DT_REG).
o Close the directory using closedir().
Execution Steps:
1. Compile the program using a C compiler (e.g., gcc -o list_files list_files.c).
2. Navigate to the directory you want to list files in using the terminal.
3. Run the compiled program (./list_files).
4. The program will print the names of all regular files in the current directory.
Note: This program lists only regular files (DT_REG). If you want to list directories as well, you
can modify the condition inside the while loop to include directories (DT_DIR).
