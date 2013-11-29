//
//  ViewController.m
//  pruebaLeerXML
//
//  Created by Dacio Leal Rodriguez on 28/11/13.
//  Copyright (c) 2013 Dacio Leal Rodriguez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    contactos = [[NSMutableArray alloc] init];
    contacto = [[NSMutableDictionary alloc] init];
    nombreEtiqueta = [[NSMutableString alloc] init];
    
    
    NSString *xml = [[NSBundle mainBundle] pathForResource:@"Ejemplo" ofType:@"xml"];
    NSString *xmlFile = [[NSString alloc] initWithContentsOfFile:xml encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", xml);
    NSLog(@"%@", xmlFile);
    
    xmlParser = [[NSXMLParser alloc] initWithData:[xmlFile dataUsingEncoding:NSUTF8StringEncoding]];
    xmlParser.delegate = self;
    [xmlParser parse];
    
    NSLog(@"\n\nArray de contactos:\n%@", contactos);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSXMLParserDelegate methods

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    
    NSLog(@"\nInicio de lectura del fichero");
    profundidad = 0;
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"\nFin de lectura del fichero");
}




- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    
    
    NSLog(@"Etiqueta <%@>", elementName);
    
    
    nombreEtiqueta = [elementName copy];
    
    
    profundidad++;
    [self mostrarProfundidad];
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSLog(@"Fin Etiqueta <\\%@>", elementName);
    
    profundidad--;
    
    nombreEtiqueta = [[NSMutableString alloc] init];
    [self mostrarProfundidad];
    
    // Insertamos el contacto e inicializamos para el proximo contacto
    
    if ([elementName isEqualToString:@"contacto"]) {
        
        [contactos addObject:contacto];
        contacto = [[NSMutableDictionary alloc] init];
    }
    
}


- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSLog(@"Elemento: %@", string);
    
    if ( profundidad == 3)
    [contacto setObject:string forKey:nombreEtiqueta];
    
}



- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSLog(@"Error: %@", [parseError localizedDescription]);
}

- (void) mostrarProfundidad {
    
    NSLog(@"Profundidad = %i", profundidad);
}


@end
