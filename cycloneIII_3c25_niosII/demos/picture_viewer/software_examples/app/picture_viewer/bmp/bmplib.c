#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <assert.h>
#include <alloca.h>


#include "bmplib.h"


#define ISLITTLEENDIAN 1



#define WORD unsigned short
#define DWORD unsigned int
#define LONG int
#define BYTE unsigned char
#define BOOL int
#define FALSE 0
#define TRUE 1

typedef struct tagBITMAPFILEHEADER {
    WORD bfType;
    DWORD bfSize;
    WORD bfReserved1;
    WORD bfReserved2;
    DWORD bfOffBits;
} BITMAPFILEHEADER;

typedef struct tagBITMAPINFOHEADER {
    DWORD  biSize;
    LONG   biWidth;
    LONG   biHeight;
    WORD   biPlanes;
    WORD   biBitCount;
    DWORD  biCompression;
    DWORD  biSizeImage;
    LONG   biXPelsPerMeter;
    LONG   biYPelsPerMeter;
    DWORD  biClrUsed;
    DWORD  biClrImportant;
} BITMAPINFOHEADER;



typedef struct tagBuf
{
    union {
        unsigned int buf : 32;
        unsigned char vbuf[4];
    } BufU;
    int buflen;
} BUF;

#define BITMAPFILEHEADER_SIZE ( sizeof( WORD ) * 3 + sizeof( DWORD ) * 2 )
#define BITMAPINFOHEADER_SIZE ( sizeof( WORD ) * 2 + sizeof( DWORD ) * 5 + sizeof( LONG ) * 4 )


static int PixIdx( int w, int h, const IBMP *pBmp );


IBMP* BmpIO_CreateBitmap( int width, int height, int BitPerPixcel )
{
    IBMP *p = NULL;

    assert( BitPerPixcel == 24 ||
        BitPerPixcel == 8 ||
        BitPerPixcel == 4 ||
        BitPerPixcel == 1 );
    if ( BitPerPixcel != 24 && BitPerPixcel != 8 &&
            BitPerPixcel != 4 && BitPerPixcel != 1 )
        return NULL;

    p = (IBMP*)malloc( sizeof( IBMP ) );
    if ( NULL == p ) return NULL;
    p->pColor = NULL;
    p->pPix = NULL;

    if ( 24 == BitPerPixcel ) {
        p->pColor = (ICOLOR*)calloc( width * height, sizeof( ICOLOR ) );
        if ( NULL == p->pColor ) goto ERR_EXIT;
    }
    else {
        p->pColor = (ICOLOR*)calloc( ( 1 << BitPerPixcel ), sizeof( ICOLOR ) );
        p->pPix = (unsigned char*)calloc( width * height, sizeof( unsigned char ) );
        if ( NULL == p->pColor || NULL == p->pPix ) goto ERR_EXIT;
    }

    p->width = width;
    p->height = height;
    p->BitPerPix = BitPerPixcel;

    return p;

ERR_EXIT:
    free( p->pColor );
    free( p->pPix );
    free( p );
    return NULL;
}

void BmpIO_DeleteBitmap( IBMP *pBmp )
{
    if ( NULL == pBmp ) return ;
    if ( NULL != pBmp->pPix ) free( pBmp->pPix );
    if ( NULL != pBmp->pColor ) free( pBmp->pColor );
    free( pBmp );
}


int BmpIO_GetWidth( const IBMP *pBmp )
{
    assert( NULL != pBmp );
    return pBmp->width;
}

int BmpIO_GetHeight( const IBMP *pBmp )
{
    assert( NULL != pBmp );
    return pBmp->height;
}

int BmpIO_GetBitPerPixcel( const IBMP *pBmp )
{
    assert( NULL != pBmp );
    return pBmp->BitPerPix;
}

unsigned char BmpIO_GetR( int x, int y, const IBMP *pBmp )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );

    if ( pBmp->BitPerPix == 24 )
        return pBmp->pColor[ PixIdx( x, y, pBmp ) ].r;
    else
        return BmpIO_GetColorTableR( BmpIO_GetPixcel( x, y, pBmp ), pBmp );
}

unsigned char BmpIO_GetG( int x, int y, const IBMP *pBmp )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );

    if ( pBmp->BitPerPix == 24 )
        return pBmp->pColor[ PixIdx( x, y, pBmp ) ].g;
    else
        return BmpIO_GetColorTableG( BmpIO_GetPixcel( x, y, pBmp ), pBmp );
}

unsigned char BmpIO_GetB( int x, int y, const IBMP *pBmp )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );

    if ( pBmp->BitPerPix == 24 )
        return pBmp->pColor[ PixIdx( x, y, pBmp ) ].b;
    else
        return BmpIO_GetColorTableB( BmpIO_GetPixcel( x, y, pBmp ), pBmp );
}



void BmpIO_SetR( int x, int y, IBMP *pBmp, unsigned char v )
{
    assert( NULL != pBmp && NULL != pBmp->pColor && pBmp->BitPerPix == 24 );
    pBmp->pColor[ PixIdx( x, y, pBmp ) ].r = v;
}

void BmpIO_SetG( int x, int y, IBMP *pBmp, unsigned char v )
{
    assert( NULL != pBmp && NULL != pBmp->pColor && pBmp->BitPerPix == 24 );
    pBmp->pColor[ PixIdx( x, y, pBmp ) ].g = v;
}

void BmpIO_SetB( int x, int y, IBMP *pBmp, unsigned char v )
{
    assert( NULL != pBmp && NULL != pBmp->pColor && pBmp->BitPerPix == 24 );
    pBmp->pColor[ PixIdx( x, y, pBmp ) ].b = v;
}



unsigned char BmpIO_GetColorTableR( int idx, const IBMP *pBmp )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    assert( idx >= 0 && idx < ( 1 << pBmp->BitPerPix ) );
    idx = idx % ( 1 << pBmp->BitPerPix );
    return pBmp->pColor[ idx ].r;
}

unsigned char BmpIO_GetColorTableG( int idx, const IBMP *pBmp )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    assert( idx >= 0 && idx < ( 1 << pBmp->BitPerPix ) );
    idx = idx % ( 1 << pBmp->BitPerPix );
    return pBmp->pColor[ idx ].g;
}

unsigned char BmpIO_GetColorTableB( int idx, const IBMP *pBmp )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    assert( idx >= 0 && idx < ( 1 << pBmp->BitPerPix ) );
    idx = idx % ( 1 << pBmp->BitPerPix );
    return pBmp->pColor[ idx ].b;
}

void BmpIO_SetColorTableR( int idx, const IBMP *pBmp, unsigned char v )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    assert( idx >= 0 && idx < ( 1 << pBmp->BitPerPix ) );
    idx = idx % ( 1 << pBmp->BitPerPix );
    pBmp->pColor[ idx ].r = v;
}

void BmpIO_SetColorTableG( int idx, const IBMP *pBmp, unsigned char v )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    assert( idx >= 0 && idx < ( 1 << pBmp->BitPerPix ) );
    idx = idx % ( 1 << pBmp->BitPerPix );
    pBmp->pColor[ idx ].g = v;
}

void BmpIO_SetColorTableB( int idx, const IBMP *pBmp, unsigned char v )
{
    assert( NULL != pBmp && NULL != pBmp->pColor );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    assert( idx >= 0 && idx < ( 1 << pBmp->BitPerPix ) );
    idx = idx % ( 1 << pBmp->BitPerPix );
    pBmp->pColor[ idx ].b = v;
}

unsigned char BmpIO_GetPixcel( int x, int y, const IBMP *pBmp )
{
    assert( NULL != pBmp && NULL != pBmp->pColor && NULL != pBmp->pPix );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    return pBmp->pPix[ PixIdx( x, y, pBmp ) ];
}

void BmpIO_SetPixcel( int x, int y, const IBMP *pBmp, unsigned char v )
{
    assert( NULL != pBmp && NULL != pBmp->pColor && NULL != pBmp->pPix );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );
    assert( v < ( 1 << pBmp->BitPerPix ) );
    v = v % ( 1 << pBmp->BitPerPix );
    pBmp->pPix[ PixIdx( x, y, pBmp ) ] = v;
}

int BmpIO_TranseTo24BitColor( IBMP *pBmp )
{
    ICOLOR *wpColor;
    int PixCount;
    int i;

    assert( NULL != pBmp );

    if ( 24 == pBmp->BitPerPix ) return TRUE;

    assert( NULL != pBmp->pColor && NULL != pBmp->pPix );
    assert( 1 == pBmp->BitPerPix ||
            4 == pBmp->BitPerPix ||
            8 == pBmp->BitPerPix );

    PixCount = pBmp->width * pBmp->height;

    wpColor = (ICOLOR*)calloc( PixCount, sizeof( ICOLOR ) );
    if ( NULL == wpColor ) return FALSE;

    for ( i = 0; i < PixCount; i++ )
        wpColor[i] = pBmp->pColor[ pBmp->pPix[i] ];

    free( pBmp->pColor );
    free( pBmp->pPix );
    pBmp->pColor = wpColor;
    pBmp->pPix = NULL;
    pBmp->BitPerPix = 24;

    return TRUE;
}

static int PixIdx( int w, int h, const IBMP *pBmp )
{
    assert( w >= 0 && w < pBmp->width && h >= 0 && h <= pBmp->height );
    w = w % pBmp->width;
    h = h % pBmp->height;
    return h * pBmp->width + w;
}



static BOOL LoadHeader(
    FILE *infile, unsigned int *ctsize, int *blen, int *pWidth, int *pHeight
);
static BOOL LoadBody1( FILE *infile, int BitLen, IBMP *pBmp );
static BOOL LoadBody24( FILE *infile, IBMP *pBmp );
static void FrushBuf_ipt( BUF *pBuf, FILE *infile );
static int ReadBuf( BUF *pBuf, int len, FILE *infile );
static size_t int_fread( void *buffer, size_t size, size_t count, FILE *stream );

IBMP* BmpIO_Load( FILE *infile )
{
    unsigned int ctsize;
    int blen;       
    IBMP *pBmp;
    int w, h;
    BOOL r;

    if ( !LoadHeader( infile, &ctsize, &blen, &w, &h ) ) return FALSE;

    pBmp = BmpIO_CreateBitmap( w, h, blen );
    if ( NULL == pBmp ) return NULL;

    if ( 24 != blen )
        r = LoadBody1( infile, blen, pBmp );
    else
        r = LoadBody24( infile, pBmp );

    if ( !r ) {
        BmpIO_DeleteBitmap( pBmp );
        return NULL;
    }

    return pBmp;
}

static BOOL LoadHeader(
    FILE *infile,
    unsigned int *ctsize,
    int *blen,
    int *pWidth,
    int *pHeight
)
{
    BITMAPFILEHEADER bfh;
    BITMAPINFOHEADER bi;

    if ( int_fread( &( bfh.bfType ), sizeof( bfh.bfType ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bfh.bfSize ), sizeof( bfh.bfSize ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bfh.bfReserved1 ), sizeof( bfh.bfReserved1 ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bfh.bfReserved2 ), sizeof( bfh.bfReserved2 ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bfh.bfOffBits ), sizeof( bfh.bfOffBits ), 1, infile ) < 1 )
        return FALSE;

    if ( int_fread( &( bi.biSize ), sizeof( bi.biSize ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biWidth ), sizeof( bi.biWidth ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biHeight ), sizeof( bi.biHeight ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biPlanes ), sizeof( bi.biPlanes ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biBitCount ), sizeof( bi.biBitCount ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biCompression ), sizeof( bi.biCompression ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biSizeImage ), sizeof( bi.biSizeImage ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biXPelsPerMeter ), sizeof( bi.biXPelsPerMeter ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biYPelsPerMeter ), sizeof( bi.biYPelsPerMeter ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biClrUsed ), sizeof( bi.biClrUsed ), 1, infile ) < 1 )
        return FALSE;
    if ( int_fread( &( bi.biClrImportant ), sizeof( bi.biClrImportant ), 1, infile ) < 1 )
        return FALSE;
    if ( bfh.bfType != 0x4D42 ) return FALSE;

    (*blen) = bi.biBitCount;
    (*ctsize) = bi.biClrUsed;
    (*pWidth) = bi.biWidth;  
    (*pHeight) = bi.biHeight;

    return TRUE;
}

static BOOL LoadBody1( FILE *infile, int BitLen, IBMP *pBmp )
{
    int i=0, j=0;
    BUF buf;
    int ctsize = ( 1 << BitLen );   

    for ( i = 0; i < ctsize && !ferror( infile ) && !feof( infile ); i++ ) {
        pBmp->pColor[i].b = fgetc( infile );
        pBmp->pColor[i].g = fgetc( infile );
        pBmp->pColor[i].r = fgetc( infile );
        fgetc( infile );    // rgbReserved
    }
    if ( ferror( infile ) || feof( infile ) ) return FALSE;

    buf.BufU.buf = 0;
    buf.buflen = 0;
    FrushBuf_ipt( &buf, infile );

    for ( i = 0; i < pBmp->height && !feof( infile ) && !ferror( infile ); i++ ) {
        for ( j = 0; j < pBmp->width && !feof( infile ) && !ferror( infile ); j++ ) {
            int wIdx = PixIdx( j, i, pBmp );
            pBmp->pPix[ wIdx ] = ReadBuf( &buf, BitLen, infile );
        }
        FrushBuf_ipt( &buf, infile );
    }

    return ( i == pBmp->height && j == pBmp->width );
}

static BOOL LoadBody24( FILE *infile, IBMP *pBmp )
{
    int i=0, j=0;
    BUF buf;

    buf.buflen = 0;
    buf.BufU.buf = 0;
    FrushBuf_ipt( &buf, infile );

    for ( i = 0; i < pBmp->height && !feof( infile ) && !ferror( infile ); i++ ) {
        for ( j = 0; j < pBmp->width && !feof( infile ) && !ferror( infile ); j++ ) {
            BmpIO_SetB( j, i, pBmp, (unsigned char)ReadBuf( &buf, 8, infile ) );
            BmpIO_SetG( j, i, pBmp, (unsigned char)ReadBuf( &buf, 8, infile ) );
            BmpIO_SetR( j, i, pBmp, (unsigned char)ReadBuf( &buf, 8, infile ) );
        }
        FrushBuf_ipt( &buf, infile );
    }
    return ( i == pBmp->height && j == pBmp->width );
}

static void FrushBuf_ipt( BUF *pBuf, FILE *infile )
{
    int i;

#if ISLITTLEENDIAN
    for ( i = 3; i >= 0; i-- )
#else
    for ( i = 0; i < 4; i++ )
#endif
        pBuf->BufU.vbuf[ i ] = getc( infile );
    pBuf->buflen = 32;
}

static int ReadBuf( BUF *pBuf, int len, FILE *infile )
{
    int r;
    if ( pBuf->buflen < len ) FrushBuf_ipt( pBuf, infile );
    r = ( ( ( ( 1 << len ) - 1 ) << ( 32 - len ) ) & pBuf->BufU.buf ) >> ( 32 - len );
    pBuf->BufU.buf <<= len;
    pBuf->buflen -= len;
    return r;
}

size_t int_fread( void *buffer, size_t size, size_t count, FILE *stream )
{
#if ISLITTLEENDIAN
    return fread( buffer, size, count, stream );
#else
    size_t i, j;
    size_t r;
    char *cbuf = (char*)buffer;

    r = fread( buffer, size, count, stream );
    if ( 1 == size ) return r;

    for ( i = 0; i < count; i++ ) {
        for ( j = 0; j < size / 2; j++ ) {
            int idx1 = i * size + j;
            int idx2 = i * size + ( size - j - 1 );
            char c = cbuf[ idx1 ];
            cbuf[ idx1 ] = cbuf[ idx2 ];
            cbuf[ idx2 ] = c;
        }
    }
    return r;
#endif
}


static BOOL WriteHeader( FILE *outfile, const IBMP *pBmp );
static BOOL WriteBody1( FILE *outfile, const IBMP *pBmp );
static BOOL WriteBody24( FILE *outfile, const IBMP *pBmp );
static void FrushBuf_opt( BUF *pBuf, FILE *outfile );
static void WriteBuf( BUF *pBuf, int BitLen, unsigned char c, FILE *outfile );
static size_t int_fwrite( const void *buffer, size_t size, size_t count, FILE *stream );

BOOL BmpIO_Save( FILE *outfile, const IBMP *pBmp )
{
    if ( !WriteHeader( outfile, pBmp ) ) return FALSE;

    if ( 24 == pBmp->BitPerPix )
        return WriteBody24( outfile, pBmp );
    else
        return WriteBody1( outfile, pBmp );
}

static BOOL WriteHeader( FILE *outfile, const IBMP *pBmp )
{
    BITMAPFILEHEADER bfh;
    BITMAPINFOHEADER bi;

    bfh.bfType = 0x4D42;
    bfh.bfSize = 0;
    bfh.bfReserved1 = 0;
    bfh.bfReserved2 = 0;
    bfh.bfOffBits = BITMAPFILEHEADER_SIZE + BITMAPINFOHEADER_SIZE;
      if ( pBmp->BitPerPix <= 8 )
        bfh.bfOffBits += 4 * ( 1 << pBmp->BitPerPix );
    bi.biSize = BITMAPINFOHEADER_SIZE;
    bi.biWidth = pBmp->width;
    bi.biHeight = pBmp->height;
    bi.biPlanes = 1;
    bi.biBitCount = pBmp->BitPerPix;
    bi.biCompression = 0L;
    bi.biSizeImage = 0;
    bi.biXPelsPerMeter = 1;
    bi.biYPelsPerMeter = 1;
    bi.biClrUsed = 0;
    bi.biClrImportant = 0;

    if ( int_fwrite( &(bfh.bfType), sizeof( bfh.bfType ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bfh.bfSize), sizeof( bfh.bfSize ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bfh.bfReserved1), sizeof( bfh.bfReserved1 ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bfh.bfReserved2), sizeof( bfh.bfReserved2 ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bfh.bfOffBits), sizeof( bfh.bfOffBits ), 1, outfile ) < 1 )
        return FALSE;

    if ( int_fwrite( &(bi.biSize), sizeof( bi.biSize ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biWidth), sizeof( bi.biWidth ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biHeight), sizeof( bi.biHeight ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biPlanes), sizeof( bi.biPlanes ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biBitCount), sizeof( bi.biBitCount ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biCompression), sizeof( bi.biCompression ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biSizeImage), sizeof( bi.biSizeImage ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biXPelsPerMeter), sizeof( bi.biXPelsPerMeter ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biYPelsPerMeter), sizeof( bi.biYPelsPerMeter ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biClrUsed), sizeof( bi.biClrUsed ), 1, outfile ) < 1 )
        return FALSE;
    if ( int_fwrite( &(bi.biClrImportant), sizeof( bi.biClrImportant ), 1, outfile ) < 1 )
        return FALSE;

    return TRUE;
}

BOOL WriteBody1( FILE *outfile, const IBMP *pBmp )
{
    int i, j;
    int ctcnt = 1 << pBmp->BitPerPix;  
    BUF buf;

    for ( i = 0; i < ctcnt && !ferror( outfile ); i++ ) {
        fputc( pBmp->pColor[i].b, outfile );
        fputc( pBmp->pColor[i].g, outfile );
        fputc( pBmp->pColor[i].r, outfile );
        fputc( 0, outfile );
    }

    buf.BufU.buf = 0;
    buf.buflen = 0;

    for ( i = 0; i < pBmp->height; i++ ) {
        for ( j = 0; j < pBmp->width; j++ ) {
            WriteBuf( &buf, pBmp->BitPerPix, BmpIO_GetPixcel( j, i, pBmp ), outfile );
        }
        FrushBuf_opt( &buf, outfile );
    }
    return TRUE;
}

static BOOL WriteBody24( FILE *outfile, const IBMP *pBmp )
{
    int i, j;
    BUF buf;

    buf.BufU.buf = 0;
    buf.buflen = 0;

    for ( i = 0; i < pBmp->height; i++ ){
        for ( j = 0; j < pBmp->width; j++ ) {
            WriteBuf( &buf, 8, BmpIO_GetB( j, i, pBmp ), outfile );
            WriteBuf( &buf, 8, BmpIO_GetG( j, i, pBmp ), outfile );
            WriteBuf( &buf, 8, BmpIO_GetR( j, i, pBmp ), outfile );
        }
        FrushBuf_opt( &buf, outfile );
    }
    return TRUE;
}

static void FrushBuf_opt( BUF *pBuf, FILE *outfile )
{
    int i;
    if ( 0 == pBuf->buflen ) return ;

#if ISLITTLEENDIAN
    for ( i = 3; i >= 0; i-- )
#else
    for ( i = 0; i < 4; i++ )
#endif
        putc( pBuf->BufU.vbuf[ i ], outfile );

    pBuf->buflen = 0;
    pBuf->BufU.buf = 0;
}

static void WriteBuf( BUF *pBuf, int BitLen, unsigned char c, FILE *outfile )
{
    const unsigned long MASK = ( 0x1 << ( BitLen + 1 ) ) - 1;
    pBuf->BufU.buf |= ( ( (unsigned long)c ) & MASK ) << ( 32 - ( pBuf->buflen + BitLen ) );
    pBuf->buflen += BitLen;
    if ( pBuf->buflen >= 32 )
        FrushBuf_opt( pBuf, outfile );
}

size_t int_fwrite( const void *buffer, size_t size, size_t count, FILE *stream )
{
#if ISLITTLEENDIAN
    return fwrite( buffer, size, count, stream );
#else
    size_t i, j;
    char *cbuf = (char*)buffer;
    char *wbuf = (char*)alloca( size );
    size_t r;

    if ( 1 == size )
        return fwrite( buffer, size, count, stream );

    r = 0;
    for ( i = 0; i < count; i++ ) {
        for ( j = 0; j < size; j++ ) {
            int idx1 = i * size + j;
            int idx2 = i * size + ( size - j - 1 );
            wbuf[ idx2 ] = cbuf[ idx1 ];
        }
        if ( fwrite( wbuf, size, 1, stream ) < 1 )
            return r;
        r++;
    }
    return r;
#endif
};
