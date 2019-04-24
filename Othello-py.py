def main():
  board = []
  for x in range(8):
    board.append([' '] * 8)
  
  initializeBoard(board)
  
  p1 = 'B'
  p2 = 'W'


  while not isBoardFull(board):
    displayBoard(board)

    if(len(possibleMove(board,p1)) == 0 and len(possibleMove(board,p2)) == 0): 
      break

    tempBoard = makeMove(board, p1)
    if not tempBoard == False:
      board = tempBoard
    
    (p1,p2) = (p2,p1)
  
def initializeBoard(board):
  board[3][3] = 'W'
  board[3][4] = 'B'
  board[4][3] = 'B'
  board[4][4] = 'W'
  
def displayBoard(board):
  print('  0 1 2 3 4 5 6 7 ')

  for r in range(len(board)):
    s = str(r) + ' '
    for c in range(len(board[r])):
      s += board[r][c] + ' '
    print(s + str(r))
  print('  0 1 2 3 4 5 6 7 ')


def possibleMove(board,player):
  totalPossibleMoves = []

  for r in range(len(board)):
    for c in range(len(board)):
      if not isValidMove(board, r, c, player):
        continue
      else:
        if len(validMoves(board, r, c, player)) > 0:
          totalPossibleMoves.append((r, c))

  return totalPossibleMoves

def validMoves(board, r, c, player):
  piecesFlipped = []

  #checks the pieces in every direction for a valid move 

  #left,rigt,up,down
  piecesFlipped.extend(getPieces(board, r, c, 0, 1, player))
  piecesFlipped.extend(getPieces(board, r, c, 0, -1, player))
  piecesFlipped.extend(getPieces(board, r, c, 1, 0, player))
  piecesFlipped.extend(getPieces(board, r, c, -1, 0, player))

  #diagonals
  piecesFlipped.extend(getPieces(board, r, c, 1, 1, player))
  piecesFlipped.extend(getPieces(board, r, c, 1, -1, player))
  piecesFlipped.extend(getPieces(board, r, c, -1, 1, player))
  piecesFlipped.extend(getPieces(board, r, c, -1, -1, player))



  return list(set(piecesFlipped))

def flipPieces(board, flip,player):
  for i in flip:
    board[i[1]][i[0]] = player
  
  return board

def getPieces(board, r, c, x, y, player):
  includedPieces = []

  if player == 'B':
    p2 = 'W'
  else:
    p2 = 'B'

  for i in range(1,8):
    currentX = r + i * x
    currentY = c + i * y
  
    if currentX < 0 or currentX >= len(board):
      return []
    if currentY < 0 or currentY >= len(board):
      return []

    if board[currentX][currentY] == p2:
      includedPieces.append((currentX, currentY))
    elif  board[currentX][currentY] == player:
      return includedPieces
    else:
      return []
  return []

def isValidMove(board, r, c, player):
  return board[r][c] == ' '

def makeMove(board, player):
  print(player + ' it is your move')

  moves = possibleMove(board, player)

  if len(moves) == 0:
    return False 
  
  x = -1
  y = -1

  while (x, y) not in moves:
    while x < 0 or x >= len(board):
      print('Enter your x coordinate(row): ')
      x = int(input())
    while y < 0 or y >= len(board):
      print('Enter your y coordinate(column): ')
      y = int(input())
    if (x, y) not in moves:
      x = -1
      y = -1
  flip = validMoves(board, x, y, player)
  board[x][y] = player

  board = flipPieces(board, flip, player)

  return board

def isBoardFull(board):
  for r in board:
    for c in r:
      if c == ' ':
        return False
  return True

def checkWinner(board):
  blackScore = 0
  whiteScore = 0

  for r in board:
    for c in r:
      if c == 'B':
        blackScore += 1
      elif c == 'W':
        whiteScore +=1
  if(blackScore > whiteScore):
    return 'black'
  elif (blackScore < whiteScore):
    return 'white'
  else:
    return 'tie'

if __name__ == "__main__":
  main()
