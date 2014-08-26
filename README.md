Diffcorn
========

JSON Diff interpreter in Objective-C

### Changelog 0.2
- Connected with travis
- Added tests project
- Filled README.md
- Created .podspec file

### Main Components
#### DiffcornParser
// DESCRIPTION PENDING

#### DiffcornBasePersistent
The basepersistent reads the calls from the core component and translate them into a persistance action. For example a DiffcornPersistent component could take these items and persist them into the database. Or for example store them in the UserDefaults...

In case of implementing your own `DiffcornPersistent` you have to ensure it conforms the protocol `DiffcornProtocol` and then the required methods:

```objc
@protocol DiffcornProtocol <NSObject>
+ (void)new:(NSArray *)objects entityName:(NSString *)entityName;
+ (void)deleted:(NSArray *)objects entityName:(NSString *)entityName;
+ (void)patch:(NSArray *)objects entityName:(NSString *)entityName;
@end
```
