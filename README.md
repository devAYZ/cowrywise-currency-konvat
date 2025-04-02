# Currency-Konvat
A currency converter application that allows users to seamlessly convert between various currencies with real-time exchange rates.

## Requirements
- iOS: 15.0+
- Xcode: 16.0+
- Swift: 5.0+

## Dependency Manager
- Swift Package Manager (SPM): Used for managing external dependencies.

## Dependencies
The application relies on several third-party libraries to enhance its functionality:

1. **[Alamofire](https://github.com/Alamofire/Alamofire)**  
   - Used for handling network requests in a simple and elegant manner.
   - It simplifies making API calls to fetch real-time currency exchange rates.

2. **[IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)**  
   - Enhances the user experience by automatically managing the keyboard appearance.
   - Prevents text fields from being hidden when the keyboard is displayed.

3. **[SideMenu](https://github.com/jonkykong/SideMenu)**  
   - Provides an intuitive side menu navigation.
   - Allows users to easily access additional settings or currency options.

4. **[Realm](https://github.com/realm/realm-swift)**  
   - A mobile database solution used for local data persistence.
   - Stores currency conversion history, allowing offline access to past exchange rates.

5. **[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)**  
   - Simplifies JSON parsing and handling.
   - Used to efficiently process API responses from currency exchange rate providers.

6. **[Kingfisher](https://github.com/onevcat/Kingfisher)**  
   - Handles image downloading and caching.
   - Optimizes loading of country flags or currency-related images in the UI.

7. **[DGCharts](https://github.com/danielgindi/Charts)**  
   - A powerful charting library for iOS.
   - Used to visually represent currency exchange trends and historical data.

## Architecture
- MVVM (Model-View-ViewModel)  
   - Ensures separation of concerns for better maintainability and testability.
   - Views are built using **Storyboard**.
   - The CharView is built programmatically.

## Alamofire, Networking Session 
- Handles all network interactions efficiently.

## System Assets
- Text
- Images
- Fonts
- Colors

## Custom Assets
- Images: Downloaded from internet

## Branches
- main

## Links to Resources
- Product Design: [View Design on Dribbble](https://dribbble.com/shots/6647815-Calculator/attachments/6647815-Calculator?mode=media)

- API Documentation: [Fixer.io API](https://fixer.io)

- Demo Images/Video: [Watch Demo on Google Drive](https://drive.google.com/drive/folders/1yZNhN3pcvhbWqpM7wSA2ivKX1wvELogS?usp=share_link)
