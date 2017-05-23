import Foundation
import UIKit

// MARK: - LAYOUT VARIABLES -

struct LayoutVariables {
    
    // MARK: - FILEPRIVATE VARIABLES -
    
    fileprivate(set) static var orientation:UIInterfaceOrientation = .portrait {
        didSet {
            updateOrientationValues()
        }
    }
    
    fileprivate(set) static var activeFrameWidth = CGFloat(250) {
        didSet {
            updateDayViewCellWidth()
        }
    }
    
    fileprivate(set) static var activeFrameHeight = CGFloat(500) {
        didSet {
            updateMaxOffsetY()
        }
    }
    
    // Zoom scale of current layout
    fileprivate(set) static var zoomScale = CGFloat(1) {
        didSet {
            updateDayViewCellHeight()
        }
    }
    
    // Number of day columns visible depending on device orientation
    private(set) static var visibleDays: CGFloat = LayoutDefaults.visibleDaysPortrait {
        didSet {
            updateDayViewCellWidth()
        }
    }
    // Width of spacing between day columns in landscape mode
    private(set) static var dayViewHorizontalSpacing = LayoutDefaults.portraitDayViewHorizontalSpacing {
        didSet {
            updateTotalDayViewCellWidth()
        }
    }
    // Width of spacing between day columns in landscape mode
    private(set) static var dayViewVerticalSpacing = LayoutDefaults.portraitDayViewVerticalSpacing {
        didSet {
            updateTotalContentHeight()
        }
    }
    
    // Height of the initial day columns
    fileprivate(set) static var initialDayViewCellHeight = LayoutDefaults.dayViewCellHeight {
        didSet {
            updateDayViewCellHeight()
        }
    }
    // Height of the current day columns
    fileprivate(set) static var dayViewCellHeight = LayoutDefaults.dayViewCellHeight {
        didSet {
            updateTotalContentHeight()
        }
    }
    
    // Width of an entire day column
    private(set) static var dayViewCellWidth = (activeFrameWidth - dayViewHorizontalSpacing*(visibleDays-1)) / visibleDays {
        didSet {
            updateTotalDayViewCellWidth()
        }
    }
    
    // Total width of an entire day column including spacing
    private(set) static var totalDayViewCellWidth = dayViewCellWidth + dayViewHorizontalSpacing {
        didSet {
            updateMaxOffsetX()
        }
    }
    
    // Height of all scrollable content
    private(set) static var totalContentHeight = dayViewVerticalSpacing*2 + dayViewCellHeight {
        didSet {
            updateMaxOffsetY()
        }
    }
    
    
    // Visible day cells in protrait mode
    fileprivate(set) static var portraitVisibleDays = LayoutDefaults.visibleDaysPortrait {
        didSet{
            updateMaximumVisibleDays()
        }
    }
    // Visible day cells in landscape mode
    fileprivate(set) static var landscapeVisibleDays = LayoutDefaults.visibleDaysLandscape {
        didSet{
            updateMaximumVisibleDays()
        }
    }
    
    // Number of days in current year being displayed
    fileprivate(set) static var daysInActiveYear = Date().getDaysInYear(withYearOffset: 0) {
        didSet {
            updateCollectionViewCellCount()
            updateMaxOffsetX()
        }
    }
    
    // Maximum number of days visisble
    private(set) static var maximumVisibleDays = Int(max(portraitVisibleDays, landscapeVisibleDays)) {
        didSet {
            updateCollectionViewCellCount()
        }
    }
    
    // Number of cells in the collection view
    private(set) static var collectionViewCellCount = daysInActiveYear + maximumVisibleDays
    
    // Velocity multiplier for pagin
    fileprivate(set) static var velocityOffsetMultiplier = LayoutDefaults.velocityOffsetMultiplier
    
    // Min x-axis values that repeating starts at
    private(set) static var minOffsetX = CGFloat(0)
    // Max x-axis values that repeating starts at
    private(set) static var maxOffsetX = CGFloat(daysInActiveYear)*totalDayViewCellWidth
    // Min y-axis values that can be scrolled to
    private(set) static var minOffsetY = CGFloat(0)
    // Max y-axis values that can be scrolled to
    private(set) static var maxOffsetY = totalContentHeight - activeFrameHeight
    
    // Width of spacing between day columns in portrait mode
    fileprivate(set) static var portraitDayViewHorizontalSpacing = LayoutDefaults.portraitDayViewHorizontalSpacing {
        didSet {
            if orientation.isPortrait {
                dayViewHorizontalSpacing = portraitDayViewHorizontalSpacing
            }
        }
    }
    // Width of spacing between day columns in landscape mode
    fileprivate(set) static var landscapeDayViewHorizontalSpacing = LayoutDefaults.landscapeDayViewHorizontalSpacing {
        didSet {
            if orientation.isLandscape {
                dayViewHorizontalSpacing = landscapeDayViewHorizontalSpacing
            }
        }
    }
    
    // Width of spacing between day columns in portrait mode
    fileprivate(set) static var portraitDayViewVerticalSpacing = LayoutDefaults.portraitDayViewVerticalSpacing {
        didSet {
            if orientation.isPortrait {
                dayViewVerticalSpacing = portraitDayViewVerticalSpacing
            }
        }
    }
    // Width of spacing between day columns in landscape mode
    fileprivate(set) static var landscapeDayViewVerticalSpacing = LayoutDefaults.landscapeDayViewVerticalSpacing {
        didSet {
            if orientation.isLandscape {
                dayViewVerticalSpacing = landscapeDayViewHorizontalSpacing
            }
        }
    }
    
    // MARK: - UPDATE FUNCTIONS -
    
    private static func updateOrientationValues() {
        if orientation.isPortrait {
            visibleDays = portraitVisibleDays
            dayViewHorizontalSpacing = portraitDayViewHorizontalSpacing
            dayViewVerticalSpacing = portraitDayViewVerticalSpacing
        }
        else if orientation.isLandscape {
            visibleDays = landscapeVisibleDays
            dayViewHorizontalSpacing = landscapeDayViewHorizontalSpacing
            dayViewVerticalSpacing = landscapeDayViewVerticalSpacing
        }
    }
    
    private static func updateDayViewCellWidth() {
        dayViewCellWidth = (activeFrameWidth - dayViewHorizontalSpacing*(visibleDays-1)) / visibleDays
    }
    
    private static func updateDayViewCellHeight() {
        dayViewCellHeight = initialDayViewCellHeight*zoomScale
    }
    
    private static func updateTotalDayViewCellWidth() {
        totalDayViewCellWidth = dayViewCellWidth + dayViewHorizontalSpacing
    }
    
    private static func updateTotalContentHeight() {
        totalContentHeight = dayViewVerticalSpacing*2 + dayViewCellHeight
    }
    
    private static func updateMaximumVisibleDays() {
        maximumVisibleDays = Int(max(portraitVisibleDays, landscapeVisibleDays))
    }
    
    private static func updateCollectionViewCellCount() {
        collectionViewCellCount = maximumVisibleDays + daysInActiveYear
    }
    
    private static func updateMaxOffsetX() {
        maxOffsetX = CGFloat(daysInActiveYear)*totalDayViewCellWidth
    }
    
    private static func updateMaxOffsetY() {
        maxOffsetY = totalContentHeight - activeFrameHeight
    }
}

// MARK: - DAY SCROLL VIEW -
/**

 Class of the scroll view contained within the WeekView.
 
 Some variable name clarification. An INDEX refers to the position of an item in relation to all drawn objects. And OFFSET is a number which refers to an objet position in relation to something else such as period count or period size.
 
 All INDICES go from: 0 -> totalDayCount
 OFFSETS can go from: 
        * 0 -> periodSize (pageOffsets)
        * -infinity -> +infinity (periodOffsets)
        * 0 -> totalContentWidth (x-coordinate offsets)
        * 0 -> totalContentHeight
 */
class DayScrollView: UIScrollView, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {


    // All events
    var allEvents:[EventView] = []
    
    
    // MARK: - PRIVATE VARIABLES -
    
    private(set) var dayCollectionView: DayCollectionView!
    
    // Offset of current year
    private var yearOffset: Int = 0
    // Day of today in year
    private var dayOfYearToday: Int = Date().getDayOfYear()
    // Bool stores if the collection view just reset
    private var didJustResetView:Bool = false
    // Previous zoom scale of content
    private var previousZoomTouch:CGPoint?
    // Current zoom scale of content
    private var lastTouchZoomScale = CGFloat(1)
    
    
    // MARK: - CONSTRUCTORS/OVERRIDES -
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initDayScrollView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDayScrollView()
    }
    
    /**
     Generates and fills the scroll view with day columns.
     */
    private func initDayScrollView() {
        
        // Set visible days variable for device orientation
        LayoutVariables.orientation = UIApplication.shared.statusBarOrientation
        
        dayCollectionView = DayCollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: LayoutVariables.totalContentHeight), collectionViewLayout: DayCollectionViewFlowLayout())
        dayCollectionView.contentOffset = CGPoint(x: CGFloat(dayOfYearToday)*LayoutVariables.totalDayViewCellWidth, y: 0)
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        self.addSubview(dayCollectionView)
        
        self.contentSize = CGSize(width: self.bounds.width, height: dayCollectionView.frame.height)
        
        // Set scroll view properties
        self.isDirectionalLockEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollViewDecelerationRateFast
        self.delegate = self
    }
    
    override func layoutSubviews() {
    
        if self.frame.width != LayoutVariables.activeFrameWidth {
            LayoutVariables.activeFrameWidth = self.frame.width
            updateDayViewCellSize()
            dayCollectionView.contentOffset = CGPoint(x: CGFloat(dayOfYearToday)*LayoutVariables.totalDayViewCellWidth, y: 0)
        }
        
        if self.frame.height != LayoutVariables.activeFrameHeight {
            LayoutVariables.activeFrameHeight = self.frame.height
        }
    }
    
    // MARK: - DELEGATE & DATA SOURCE FUNCTIONS -
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Handle side bar animations
        if let weekView = self.superview?.superview as? WeekView {
            weekView.setTopAndSideBarPositionConstraints()
        }
        
        if let collectionView = scrollView as? DayCollectionView {
            if collectionView.contentOffset.x < LayoutVariables.minOffsetX {
                resetView(ofScrollView: collectionView, withYearOffsetChange: -1)
            }
            else if collectionView.contentOffset.x > LayoutVariables.maxOffsetX {
                resetView(ofScrollView: collectionView, withYearOffsetChange: 1)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let collectionView = scrollView as? DayCollectionView, !decelerate, didJustResetView{
            scrollToNearestPage(withScrollView: collectionView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? DayCollectionView, didJustResetView {
            scrollToNearestPage(withScrollView: collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LayoutVariables.collectionViewCellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dayViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellKeys.dayViewCell, for: indexPath) as! DayViewCell
        
        let dayCount = indexPath.row - dayOfYearToday + LayoutVariables.daysInActiveYear*yearOffset
        let dateForCell = DateSupport.getDayDate(forDaysInFuture: dayCount)
        print(dateForCell.getDayLabelString())
        dayViewCell.setDate(as: dateForCell)
        
        return dayViewCell
    }
    
    // MARK: - INTERNAL FUNCTIONS -
    
    func renderEvents() {
        
    }
    
    func showToday() {
        // TODO: IMPLEMENT WITH COLLECTION VIEW
    }

    func zoomContent(withNewScale newZoomScale: CGFloat, newTouchCenter touchCenter:CGPoint?, andState state:UIGestureRecognizerState) {
        
        // Store previous zoom scale
        let previousZoom = LayoutVariables.zoomScale

        var zoomChange = CGFloat(0)
        // If zoom just began, set last touch scale
        if state == .began {
            lastTouchZoomScale = newZoomScale
        }
        else {
            // Calculate zoom change from lastTouch and new zoom scale.
            zoomChange = newZoomScale - lastTouchZoomScale
            self.lastTouchZoomScale = newZoomScale
        }
    
        // Set current zoom
        var currentZoom = previousZoom + zoomChange
        if currentZoom < LayoutDefaults.minimumZoom {
            currentZoom = LayoutDefaults.minimumZoom
        }
        else if currentZoom > LayoutDefaults.maximumZoom {
            currentZoom = LayoutDefaults.maximumZoom
        }
        LayoutVariables.zoomScale = currentZoom
        // Update the height and contents of the visible day views
        updateVisibleDayViewCellHeight()
        // Calculate the new y content offset based on zoom change and touch center
        let m = previousZoom/currentZoom
        
        var newYOffset = self.contentOffset.y
        if touchCenter != nil {
            let oldAnchorY = touchCenter!.y+self.contentOffset.y
            let offsetChange = oldAnchorY*(m-1)
            newYOffset -= offsetChange
        }
        
        // Calculate additional y content offset change based on scrolling movements
        if let previousTouchCenter = previousZoomTouch {
            if let touch = touchCenter{
                newYOffset += (previousTouchCenter.y-touch.y)
                self.previousZoomTouch = touchCenter
            }
        }
        else {
            self.previousZoomTouch = touchCenter
        }
        
        // Check that new y offset is not out of bounds
        if newYOffset < LayoutVariables.minOffsetY {
            newYOffset = LayoutVariables.minOffsetY
        }
        else if newYOffset > LayoutVariables.maxOffsetY {
            newYOffset = LayoutVariables.maxOffsetY
        }
        
        // Pass new y offset to scroll view
        self.contentOffset.y = newYOffset
        // Render events
        renderEvents()
        
        if state == .cancelled || state == .ended || state == .failed {
            self.previousZoomTouch = nil
            scrollToNearestPage(withScrollView: dayCollectionView)
        }
    }
    
    func updateContentOrientation() {
        
        // Set the correct value for current visible days
        LayoutVariables.orientation = UIApplication.shared.statusBarOrientation
        // Update the day views and content size
        updateDayViewCellSize()
        // Render events
        renderEvents()
    }
    
    // MARK: - HELPER/PRIVATE FUNCTIONS -
    
    
    private func resetView(ofScrollView scrollView:UIScrollView, withYearOffsetChange change:Int){
        // TODO: IMPLEMENT WITH COLLECTION VIEW
        didJustResetView = true
        yearOffset += change
        LayoutVariables.daysInActiveYear = Date().getDaysInYear(withYearOffset: yearOffset)
        if change < 0 {
            scrollView.contentOffset.x = LayoutVariables.maxOffsetX
        }
        else if change > 0 {
            scrollView.contentOffset.x = LayoutVariables.minOffsetX
        }
    }
    
    private func scrollToNearestPage(withScrollView scrollView:UIScrollView) {
        let xOffset = scrollView.contentOffset.x
        let yOffset = scrollView.contentOffset.y
        
        let totalDayViewWidth = LayoutVariables.totalDayViewCellWidth
        let truncatedToPagingWidth = xOffset.truncatingRemainder(dividingBy: totalDayViewWidth)
        
        if (truncatedToPagingWidth >= 0.5 && yOffset >= LayoutVariables.minOffsetY && yOffset <= LayoutVariables.maxOffsetY){
            
            let targetXOffset = round(xOffset / totalDayViewWidth)*totalDayViewWidth
            scrollView.setContentOffset(CGPoint(x: targetXOffset, y: scrollView.contentOffset.y), animated: true)
        }
        didJustResetView = false
    }
    
    private func updateVisibleDayViewCellHeight() {
        // Update the visisible day view cell sizes
        updateDayViewCellSize()
        // Update the collection view content size
        dayCollectionView.contentSize = CGSize(width: dayCollectionView.contentSize.width, height: LayoutVariables.totalContentHeight)
        self.contentSize = CGSize(width: self.bounds.width, height: LayoutVariables.totalContentHeight)
        // Update the frame of the collection view
        dayCollectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: LayoutVariables.totalContentHeight)
    }
    
    private func updateDayViewCellSize() {
        
        if let flowLayout = dayCollectionView.collectionViewLayout as? DayCollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: LayoutVariables.dayViewCellWidth, height: LayoutVariables.dayViewCellHeight)
        }
        
    }
    
}

// MARK: - CUSTOMIZATION SETTERS -

extension DayScrollView {
    
    func setInitialVisibleDayViewCellHeight(to height: CGFloat) {
        LayoutVariables.initialDayViewCellHeight = height
    }
    
    /**
     Return true if content view was changed
     */
    func setVisiblePortraitDays(to days:CGFloat) -> Bool{
        
        // Set portrait visisble days variable
        LayoutVariables.portraitVisibleDays = days
        // If device orientation is portrait
        if UIApplication.shared.statusBarOrientation.isPortrait {
            updateContentOrientation()
            return true
        }
        else {
            return false
        }
    }
    
    /**
     Return true if content view was changed
     */
    func setVisibleLandscapeDays(to days:CGFloat) -> Bool{
        
        // Set portrait visisble days variable
        LayoutVariables.landscapeVisibleDays = days
        // If device orientation is portrait
        if UIApplication.shared.statusBarOrientation.isLandscape {
            updateContentOrientation()
            return true
        }
        else {
            return false
        }
    }
    
    func setVelocityOffsetMultiplier(to multiplier:CGFloat) {
        LayoutVariables.velocityOffsetMultiplier = multiplier
    }
    
    func setPortraitDayViewSideSpacing(to width:CGFloat) -> Bool{
        LayoutVariables.portraitDayViewHorizontalSpacing = width
        if LayoutVariables.orientation.isPortrait {
            updateContentOrientation()
            return true
        }
        else {
            return false
        }
    }
    
    func setLandscapeDayViewSideSpacing(to width:CGFloat) -> Bool{
        LayoutVariables.landscapeDayViewHorizontalSpacing = width
        if LayoutVariables.orientation.isLandscape {
            updateContentOrientation()
            return true
        }
        else {
            return false
        }
    }
}
