defmodule CustomerDashboardWeb.RegistrationHTML do
  use CustomerDashboardWeb, :html

  embed_templates "registration_html/*"

  @doc """
  Renders a application form.
  """

  # attr :page, :integer, required: true
  # attr :changeset, Ecto.Changeset, required: true
  # attr :action, :string, required: true

  def render_page_header(page) do
    assigns = %{
      header_text:
        case page do
          "1" -> "Let's start with your basic information"
          "2" -> "How can we contact you?"
          "3" -> "Tell us a bit more about yourself"
          "4" -> "Where do you live?"
          "5" -> "What is your monthly income?"
          "6" -> "What type of income do you have?"
          "7" -> "Banking information"
          "8" -> "Create your account"
          "9" -> "Almost done! Please review our terms"
          _ -> "Application"
        end
    }

    ~H"""
    <h2 class="text-xl font-semibold mb-6">{@header_text}</h2>
    """
  end

  def render_progress_bar(page) do
    assigns = %{percent_complete: page * 100 / 9}

    ~H"""
    <div class="fixed bottom-0 left-0 w-full bg-gray-100 h-2">
      <div class="bg-blue-600 h-full" style={"width: #{@percent_complete}%"}></div>
    </div>
    """
  end

  def application_form(assigns) do
    ~H"""
    <.simple_form :let={f} for={@changeset} action={@action}>
      {render_form_fields(f, @page)}
      <:actions>
        <.button>Next</.button>
      </:actions>
    </.simple_form>
    """
  end

  defp render_form_fields(f, 1) do
    assigns = %{f: f}

    ~H"""
    <.input field={@f[:first_name]} type="text" label="First Name" required />
    <.input field={@f[:last_name]} type="text" label="Last Name" required />
    """
  end

  defp render_form_fields(f, 2) do
    assigns = %{f: f}

    ~H"""
    <.input field={@f[:email]} type="email" label="Email Address" required />
    <.input
      field={@f[:phone_number]}
      type="tel"
      label="Phone Number"
      required
      placeholder="(123) 456-7890"
      pattern="\(\d{3}\) \d{3}-\d{4}"
      phx-hook="PhoneNumberMask"
    />
    """
  end

  defp render_form_fields(f, 3) do
    assigns = %{f: f}

    ~H"""
    <.input field={@f[:date_of_birth]} type="date" label="Date of Birth" required />
    <.input field={@f[:ssn]} type="text" label="Social Security Number" required maxlength="9" />
    <p class="text-sm text-gray-500">Please enter your 9-digit SSN without dashes or spaces</p>
    """
  end

  defp render_form_fields(f, 4) do
    assigns = %{f: f}

    ~H"""
    <.input field={@f[:address_street1]} type="text" label="Street Address" required />
    <.input field={@f[:address_street2]} type="text" label="Street Address Line 2" />
    <.input field={@f[:address_city]} type="text" label="City" required />
    <.input field={@f[:address_state]} type="text" label="State/Province" required />
    <.input field={@f[:address_zip]} type="text" label="Postal Code" required />
    """
  end

  defp render_form_fields(f, 5) do
    assigns = %{f: f}

    ~H"""
    <.input
      field={@f[:monthly_income]}
      type="number"
      label="Monthly Income"
      required
      min="0"
      step="0.01"
    />
    """
  end

  defp render_form_fields(f, 6) do
    assigns = %{f: f}

    ~H"""
    <.input
      field={@f[:income_type]}
      type="select"
      label="Income Type"
      required
      options={[
        Employment: "Employment",
        "Self-Employment": "Self-Employment",
        "Other Taxable Income": "Other Taxable Income",
        "Other Non-Taxable Income": "Other Non-Taxable Income"
      ]}
    />
    """
  end

  defp render_form_fields(f, 7) do
    assigns = %{f: f}

    ~H"""
    <.input field={@f[:bank_name]} type="text" label="Bank Name" required />
    <.input field={@f[:routing_number]} type="text" label="Routing Number" required maxlength="9" />
    <.input field={@f[:account_number]} type="text" label="Account Number" required />
    <.input
      field={@f[:account_number_confirmation]}
      type="text"
      label="Confirm Account Number"
      required
    />
    """
  end

  defp render_form_fields(f, 8) do
    assigns = %{f: f}

    ~H"""
    <div class="mb-4">
      <div class="text-sm text-gray-500 font-semibold">Your email address</div>
      <div>{Phoenix.HTML.Form.input_value(@f, :email)}</div>
    </div>
    <.input field={@f[:password]} type="password" label="Password" required />
    <.input field={@f[:password_confirmation]} type="password" label="Confirm Password" required />
    <p class="text-sm text-gray-500">
      Password must be at least 12 characters long and include at least one uppercase letter,
      one lowercase letter, one digit, and one special character (!@#$%^&*).
    </p>
    """
  end

  defp render_form_fields(f, 9) do
    assigns = %{f: f}

    ~H"""
    <div class="mb-6 text-sm text-gray-600">
      <h3 class="text-lg font-bold mb-2">Privacy Policy and Terms of Service</h3>
      <p class="mb-2">
        By checking the box below, you acknowledge that you have read and agree to our
        Privacy Policy, Terms of Service, and consent to the processing of your personal
        information as described in our Privacy Policy.
      </p>
      <p>
        We collect and process your personal information to provide our services, comply
        with legal obligations, and protect our legitimate business interests. Your information
        may be shared with third parties as described in our Privacy Policy.
      </p>
    </div>
    <.input
      field={@f[:agreed_to_terms]}
      type="checkbox"
      label="I agree to the Privacy Policy and Terms of Service"
      required
    />
    """
  end
end
