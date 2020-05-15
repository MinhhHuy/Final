using Final.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Final
{
    public partial class fAdmin : Form
    {
        public fAdmin()
        {
            InitializeComponent();

            LoadAccountList();
        }

        void LoadAccountList()
        {
        
            string query = "EXEC dbo.USP_GetAccountByUserName @userName";

            dtgvAccount.DataSource = DataProvider.Instance.ExecuteQuery(query, new object[] { "pro"});
        }

        void LoadFoodList()
        {
            string query = "SELECT * FROM FOOD";
            dtgvFood.DataSource = DataProvider.Instance.ExecuteQuery(query);
        }
        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btnShowFood_Click(object sender, EventArgs e)
        {

        }

        private void txbDisplayName_TextChanged(object sender, EventArgs e)
        {

        }

        private void fAdmin_Load(object sender, EventArgs e)
        {

        }

        private void tpAccount_Click(object sender, EventArgs e)
        {

        }
    }
}
