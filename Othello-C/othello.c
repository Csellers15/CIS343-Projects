//***************************************************
// Filename: othello.c
//
// Author:  Prof. Nandigam
//          Blake Lapum 
//          Cole Sellers
//***************************************************

#include "othello.h"

// Displays the board (as SIZE x SIZE grid) on console
void displayBoard(char board[][SIZE])
{
    printf("\n");
    for (int i = 0; i < SIZE; i++) {
        printf((i == 0 ? "%5d" : "%3d"), i+1);
    }
    printf("\n");

    for (int i = 0; i < SIZE; i++) {
        printf("%2d", i+1);
        for (int j = 0; j < SIZE; j++) {
            printf("%3c", board[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

// Initializes the board with start configuration of discs (see project specs)
void initializeBoard(char board[][SIZE])
{
    //initializing all empty discs (8x8)
    for(int i = 0; i < SIZE; i++) {
        for(int j = 0; j < SIZE; j++) {
            board[i][j] = EMPTY; 
        }
    }
  
    //initial placement of BLACK and WHITE discs
    board[SIZE/2][SIZE/2] = BLACK;
    board[SIZE/2 - 1][SIZE/2 - 1] = BLACK;
    board[SIZE/2][SIZE/2 - 1] = WHITE;
    board[SIZE/2 - 1][SIZE/2] = WHITE;
}

// Returns true if moving the disc to location row,col is valid; else returns false
bool isValidMove(char board[][SIZE], int row, int col, char disc) {
    //row and column
    int r, c;  
    if(board[row][col] == EMPTY) {
        // flips any opponent discs diagonal down left (southwest)
        r = row + 1;
        c = col - 1;
        while (r < SIZE && c >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            r++;
            c--;
        }

        if (r < SIZE && c >= 0 && board[r][c] == disc) {
            for (int i = row + 1, j = col - 1; i < r && j > c; i++, j--) {
                if(board[i+1][j-1] == disc) {
                    //printf("down/left\n");
                    return true; 
                }
            }
        }

        // flips any opponent discs diagonal down right
        r = row + 1;
        c = col + 1;
        while (r < SIZE && c < SIZE && board[r][c] != EMPTY && board[r][c] != disc) {
            r++;
            c++;
        }

        if (r < SIZE && c < SIZE && board[r][c] == disc) {
            for (int i = row + 1, j = col + 1; i < r && j < c; i++, j++) {
                if(board[i+1][j+1] == disc) {
                    return true; 
                }
            }
        }

        // flips any opponent discs down
        r = row + 1;
        c = col;
        while (r < SIZE&& board[r][c] != EMPTY && board[r][c] != disc) {
            r++;
        }

        if (r < SIZE && board[r][c] == disc) {
            for (int i = row + 1; i < r; i++) {
                if(board[i+1][col] == disc) {
                    return true; 
                }
            }
        }

        // flips any opponent discs right
        r = row;
        c = col + 1;
        while (c < SIZE && board[r][c] != EMPTY && board[r][c] != disc) {
            c++;
        }

        if (c < SIZE && board[r][c] == disc) {
            for (int j = col + 1; j < c; j++) {
                if(board[row][j+1] == disc) {
                    return true; 
                }
            }
        }

        // flips any opponent discs left
        r = row;
        c = col - 1;
        while (c >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            c--;
        }

        if (c >= 0 && board[r][c] == disc) {
            for (int j = col - 1; j > c; j--) {
                if(board[row][j-1] == disc) {
                    return true; 
                }
            }
        }

        // flips any opponent discs diagonal up right
        r = row - 1;
        c = col + 1;
        while (r >= 0 && c < SIZE && board[r][c] != EMPTY && board[r][c] != disc) {
            r--;
            c++;
        }

        if (r >=0 && c < SIZE && board[r][c] == disc) {
            for (int i = row - 1, j = col + 1; i > r && j < c; i--, j++) {
                if(board[i-1][j+1] == disc) {
                    return true; 
                }
            }
        }

        // flips any opponent discs diagonal up left
        r = row - 1;
        c = col - 1;
        while (r >= 0 && c >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            r--; 
            c--; 
        }

        if (r >= 0 && c >= 0 && board[r][c] == disc) {
            for (int i = row - 1, j = col - 1; i > r && j > c; i--, j--) {
                if(board[i-1][j-1] == disc) {
                    return true; 
                }
            }
        }

        // flips any opponent discs diagonal up
        r = row - 1;
        c = col;
        while (r >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            r--;
        }

        if (r >= 0 && board[r][c] == disc) {
            for (int i = row - 1; i > r; i--) {
                if(board[i-1][col] == disc) {
                    return true; 
                }
            }
        }
    }
    return false;
}

void placeDiscAt(char board[][SIZE], int row, int col, char disc){
    //row and column
    int r, c;  

    if(isValidMove(board, row, col, disc)) {
        // flips any opponent discs diagonal down left (southwest)
        r = row + 1;
        c = col - 1;
        while (r < SIZE && c >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            r++;
            c--;
        }

        if (r < SIZE && c >= 0 && board[r][c] == disc) {
            for (int i = row + 1, j = col - 1; i < r && j > c; i++, j--) {
                board[i][j] = disc;
            }
        }

        // flips any opponent discs diagonal down right
        r = row + 1;
        c = col + 1;
        while (r < SIZE && c < SIZE && board[r][c] != EMPTY && board[r][c] != disc) {
            r++;
            c++;
        }

        if (r < SIZE && c < SIZE && board[r][c] == disc) {
            for (int i = row + 1, j = col + 1; i < r && j < c; i++, j++) {
                board[i][j] = disc;
            }
        }

        // flips any opponent discs down
        r = row + 1;
        c = col;
        while (r < SIZE&& board[r][c] != EMPTY && board[r][c] != disc) {
            r++;
        }

        if (r < SIZE && board[r][c] == disc) {
            for (int i = row + 1; i < r; i++) {
                board[i][col] = disc;
            }
        }

        // flips any opponent discs right
        r = row;
        c = col + 1;
        while (c < SIZE && board[r][c] != EMPTY && board[r][c] != disc) {
            c++;
        }

        if (c < SIZE && board[r][c] == disc) {
            for (int j = col + 1; j < c; j++) {
                board[row][j] = disc;
            }
        }

        // flips any opponent discs left
        r = row;
        c = col - 1;
        while (c >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            c--;
        }

        if (c >= 0 && board[r][c] == disc) {
            for (int j = col - 1; j > c; j--) {
                board[row][j] = disc;
            }
        }

        // flips any opponent discs diagonal up right
        r = row - 1;
        c = col + 1;
        while (r >= 0 && c < SIZE && board[r][c] != EMPTY && board[r][c] != disc) {
            r--;
            c++;
        }

        if (r >=0 && c < SIZE && board[r][c] == disc) {
            for (int i = row - 1, j = col + 1; i > r && j < c; i--, j++) {
                board[i][j] = disc;
            }
        }

        // flips any opponent discs diagonal up left
        r = row - 1;
        c = col - 1;
        while (r >= 0 && c >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            r--; 
            c--; 
        }

        if (r >= 0 && c >= 0 && board[r][c] == disc) {
            for (int i = row - 1, j = col - 1; i > r && j > c; i--, j--) {
                board[i][j] = disc;
            }
        }

        // flips any opponent discs diagonal up
        r = row - 1;
        c = col;
        while (r >= 0 && board[r][c] != EMPTY && board[r][c] != disc) {
            r--;
        }

        if (r >= 0 && board[r][c] == disc) {
            for (int i = row - 1; i > r; i--) {
                board[i][col] = disc;
            }
        }
        
        board[row][col] = disc; 
    }
}


// Returns true if a valid move for disc is available; else returns false
bool isValidMoveAvailable(char board[][SIZE], char disc)
{
    for(int i = 0; i < SIZE; i++) {
        for(int j = 0; j < SIZE; j++) {
            if(isValidMove(board, i, j, disc)) {
                return true; 
            }
        }
    }

    return false; 
}

// Returns true if the board is fully occupied with discs; else returns false
bool isBoardFull(char board[][SIZE])
{
    for(int i = 0; i < SIZE; i++){
        for(int j = 0; j< SIZE; j++){
            if (board[i][j] == EMPTY){
               return false; 
            }
        }
    }

    return true;
}

// Returns true if either the board is full OR a valid move is not available for either disc
bool isGameOver(char board[][SIZE]) {
    if(isBoardFull(board)) {
        return true; 
    } 
    else if(!isValidMoveAvailable(board, WHITE) && !isValidMoveAvailable(board, BLACK)) {
        return true; 
    }
    else {
        return false; 
    }
}

// If there is a winner, it returns the disc (BLACK or WHITE) associated with the winner.
// In case of a tie, it returns EMPTY
char checkWinner(char board[][SIZE])
{
    int countWhite = 0;
    int countBlack = 0;

    for(int i = 0; i < SIZE; i++){
        for(int j = 0; j < SIZE; j++){
            if(board[i][j] == WHITE){
                countWhite +=1; 
            } else if(board[i][j] == BLACK) {
                countBlack +=1;
            }
            continue; 
        }
    }

    printf("White Score: %d\n", countWhite);
    printf("Black Score: %d\n", countBlack);

    if (countWhite > countBlack){
        return WHITE;
    } else if(countBlack > countWhite){
        return BLACK;
    }
    
    return EMPTY;
}