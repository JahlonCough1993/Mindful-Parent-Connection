// Core Imports
import android.content.Context
import android.os.Bundle
import android.support.v4.content.ContextCompat
import android.support.v7.app.AppCompatActivity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView

// Mindful Parent Connection Activity
class MindfulParentConnection : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_mindful_parent_connection)
        
        // Set up inital view
        setUpView()
    }
    
    private fun setUpView() {
        // Set up header
        val headerTextView = findViewById<TextView>(R.id.header_text_view)
        headerTextView.setText(R.string.mindful_parent_connection)
        headerTextView.setTextColor(ContextCompat.getColor(this, R.color.light_blue))
        
        // Set up image
        val imageView = findViewById<ImageView>(R.id.image_view)
        imageView.setImageResource(R.drawable.parent_connection_image)

        // Set up description
        val descriptionTextView = findViewById<TextView>(R.id.description_text_view)
        descriptionTextView.setText(R.string.mindful_parent_connection_description)
        descriptionTextView.setTextColor(ContextCompat.getColor(this, R.color.light_blue))

        // Set up list
        val listView = findViewById<ViewGroup>(R.id.list_view)
        for (i in 0 until 5) {
            val listItem = createListItem(this, i)
            listView.addView(listItem)
        }
    }
    
    // Create a list item from the given index
    private fun createListItem(context: Context, index: Int): View {
        // Inflate the list item view
        val inflater = LayoutInflater.from(context)
        val listItemView = inflater.inflate(R.layout.list_item_mindful_parent_connection, null, false)

        // Get the list item data
        val listItemData = getListItemDataFromIndex(index)

        // Set up the list item view
        listItemView.findViewById<TextView>(R.id.title_text_view).setText(listItemData.titleResId)
        listItemView.findViewById<TextView>(R.id.description_text_view).setText(listItemData.descriptionResId)
        listItemView.findViewById<ImageView>(R.id.image_view).setImageResource(listItemData.imageResId)
        
        // Return the list item view
        return listItemView
    }
    
    // Get the list item data from the given index
    private fun getListItemDataFromIndex(index: Int): ListItemData {
        return when (index) {
            0 -> ListItemData(
                R.string.list_item_1_title,
                R.string.list_item_1_description,
                R.drawable.list_item_1_image
            )
            1 -> ListItemData(
                R.string.list_item_2_title,
                R.string.list_item_2_description,
                R.drawable.list_item_2_image
            )
            2 -> ListItemData(
                R.string.list_item_3_title,
                R.string.list_item_3_description,
                R.drawable.list_item_3_image
            )
            3 -> ListItemData(
                R.string.list_item_4_title,
                R.string.list_item_4_description,
                R.drawable.list_item_4_image
            )
            4 -> ListItemData(
                R.string.list_item_5_title,
                R.string.list_item_5_description,
                R.drawable.list_item_5_image
            )
            else -> throw IllegalArgumentException("Invalid list item index: $index")
        }
    }
    
    // Data class for each list item
    private data class ListItemData(
        val titleResId: Int,
        val descriptionResId: Int,
        val imageResId: Int
    )
}